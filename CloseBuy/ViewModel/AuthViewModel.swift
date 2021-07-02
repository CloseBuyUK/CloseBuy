//
//  AuthViewModel.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 20/06/2021.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

enum AuthStatus {
    case signedIn
    case signedOut
    case error
}

enum RegistrationStatus {
    case phoneNumber
    case confirmPhoneNumber
    case register
}

class AuthViewModel: ObservableObject {
    
    @Published var authStatus: AuthStatus = .signedOut
    @Published var registrationStatus: RegistrationStatus = .phoneNumber
    @Published var currentUser: User?
    
    static var shared = AuthViewModel()
    
    init(){
        updateAuthStatus()
    }
    
    func updateAuthStatus(){
        
        if isCurrentUserSignedIn {
            authStatus = .signedIn
            getUser()
        }
        else { authStatus = .signedOut }
    }
    
    func verifyPhoneNumber(_ phoneNumber: String, completion: @escaping (Bool) -> Void) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            
            if let err = error {
                print("DEBUG: \(err.localizedDescription)")
            }
            
            guard let id = verificationID else { return }
            
            UserDefaults.standard.set(id, forKey: "authVerificationID")
            
            completion(true)
            
        }
    }
    
    func verifyPhoneNumberCode(_ code: String, completion: @escaping (Bool) -> Void) {
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        
        guard let id = verificationID else { return }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: id,
            verificationCode: code)
        
        Auth.auth().signIn(with: credential) { authResult, error in
            if let err = error {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            
            print("Phone succesfully signed up")
            completion(true)
        }
        
    }
    
    func getUser(){
        guard let id = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(id).getDocument { document, _ in
            
            guard let user = try? document?.data(as: User.self) else {
                print("Can't convert data")
                return
            }
            
            self.currentUser = user
        }
        
    }
    
    func register(_ email: String, _ password: String, _ displayName: String, completion: @escaping (Bool) -> Void ){
        let credential = EmailAuthProvider.credential(withEmail: email, password: password)
        
        Auth.auth().currentUser?.link(with: credential) { (authResult, error) in
            
            if let err = error {
                print("DEBUG: \(err.localizedDescription)")
                self.registrationStatus = .phoneNumber
                return
            }
            
            guard let id = authResult?.user.uid else { return }
            
            let data: [String: Any] = [
                "accountCreatedAt": Timestamp.init(),
                "profileImageURL": "coffee",
                "email": email,
                "username": displayName,
                "uid": id
            ]
            
            Firestore.firestore().collection("users").document(id).setData(data)
            
            self.getUser()
            
            print("User is linked")
            completion(true)
        }
    }
    
    func login(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { dataResult, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let _ = dataResult?.user else { return }
            
            
            self.updateAuthStatus()
            
        }
    }
    
    func signOut(){
        try? Auth.auth().signOut()
        authStatus = .signedOut
        registrationStatus = .phoneNumber
        currentUser = nil
    }
    
    
    private var isCurrentUserSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
