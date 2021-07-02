//
//  LandingView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 20/06/2021.
//

import SwiftUI

struct PrettyButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(25)
            .font(.system(size: 18, weight: .bold))
    }
}

struct PrettyTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
    }
}


struct LandingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Spacer()
            
            NavigationLink(
                destination: LoginView(),
                label: {
                    Text("LOGIN")
                        .modifier(PrettyButton())
                })
            
            NavigationLink(
                destination: RegisterView(),
                label: {
                    Text("REGISTER")
                        .modifier(PrettyButton())
                })
        }
        .padding(.horizontal, 20)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
