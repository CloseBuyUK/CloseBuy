//
//  LoginView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 19/06/2021.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            TextField("Email Address", text: $email)
                .modifier(PrettyTextField())
            SecureField("Password", text: $password)
                .modifier(PrettyTextField())
            
            Button(action: {
                AuthViewModel.shared.login(email, password)
            }, label: {
                Text("Login")
            })
            .modifier(PrettyButton())
        }
        .padding(.horizontal, 20)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
