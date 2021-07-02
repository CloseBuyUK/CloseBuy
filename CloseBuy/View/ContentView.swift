//
//  ContentView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 18/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        NavigationView {
            Group {
                switch authViewModel.authStatus {
                case .signedOut:
                    LandingView()
                case .signedIn:
                    if let user = authViewModel.currentUser {
                        TabBarView(user: user)
                    }
                case .error:
                    Text("Error 404")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
