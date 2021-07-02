//
//  RegisterView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 19/06/2021.
//

import SwiftUI

struct RegisterView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack {
            PhoneNumberView()
        }
        .padding(.horizontal, 20)
        
    }
}

struct PhoneNumberView: View {
    
    @State var phoneNumber: String = ""
    @State var canContinue: Bool = false
    
    var body: some View {
        VStack {
            
            TextField("Phone Number", text: $phoneNumber)
                .modifier(PrettyTextField())
            
            NavigationLink(
                destination: ConfirmCodeView(),
                isActive: $canContinue,
                label: {
                    Button(action: {
                        AuthViewModel.shared.verifyPhoneNumber(phoneNumber) { response in
                            canContinue = response
                        }
                    }, label: {
                        Text("Submit")
                            .modifier(PrettyButton())
                    })
                })
            
            Spacer()
        }
    }
}

struct ConfirmCodeView: View {
    
    @State var code: String = ""
    @State var canContinue: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            
            TextField("Code", text: $code)
                .modifier(PrettyTextField())
            
            NavigationLink(
                destination: RegistrationView(),
                isActive: $canContinue,
                label: {
                    
                    Button(action: {
                        AuthViewModel.shared.verifyPhoneNumberCode(code) { response in
                            canContinue = response
                        }
                    }, label: {
                        Text("Verify")
                            .modifier(PrettyButton())
                    })
                })
        }
    }
}

struct RegistrationView: View {
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var canContinue: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Display Name", text: $displayName)
                .modifier(PrettyTextField())
            TextField("Email", text: $email)
                .modifier(PrettyTextField())
            SecureField("Password", text: $password)
                .modifier(PrettyTextField())
            
            NavigationLink(
                destination: RequestLocationView(),
                isActive: $canContinue,
                label: {
                    Button(action: {
                        AuthViewModel.shared.register(email, password, displayName) { response in
                            canContinue = response
                        }
                    }, label: {
                        Text("Create Account")
                            .modifier(PrettyButton())
                    })
                })
        }
    }
}

struct RequestLocationView: View {
    
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        Text("Almost Done")
        NavigationLink(
            destination: RequestNotificationsView(),
            label: {
                Image(systemName: "chevron.right")
            })
    }
}

struct RequestNotificationsView: View {
    
    @StateObject var notificationManager = NotificationManager()
    
    var body: some View {
        
        Button(action: {
            AuthViewModel.shared.updateAuthStatus()
        }, label: {
            Text("Completed")
        })
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
