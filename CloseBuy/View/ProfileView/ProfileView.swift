//
//  AccountView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 21/06/2021.
//

import SwiftUI
import FirebaseFirestore

struct ProfileView: View {
    
    let userExample = User(accountCreatedAt: Timestamp.init(), profileImageURL: "coffee", email: "connorepic123@gmail.com", username: "Connor Lynch", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore", id: UUID().uuidString)
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init(id: "H2xv9MxANgOuJfvePlo33qvVaGq2")){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        VStack {
            
            if let user = viewModel.user {
                Profile(user: user)
                    .environmentObject(viewModel)
            }else{
                ProgressView()
            }
        }
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.top)
    }
}

struct ProfileView_Previews: PreviewProvider {
    
    static let user = User(accountCreatedAt: Timestamp.init(), profileImageURL: "coffee", email: "connorepic123@gmail.com", username: "Connor Lynch", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore", id: UUID().uuidString)
    
    static var previews: some View {
        ProfileView(viewModel: ProfileView.ViewModel(id: "H2xv9MxANgOuJfvePlo33qvVaGq2"))
    }
}

struct Profile: View {
    
    let user: User
    @EnvironmentObject var viewModel: ProfileView.ViewModel
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Image(user.profileImageURL)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .clipped()
                
                HStack(alignment: .bottom, spacing: 20) {
                    
                    if !viewModel.isCurrentUser {
                        
                        ProfileActionButton(icon: "bell"){
                            
                        }
                    }
                    
                    Image(user.profileImageURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 125, height: 125)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    if !viewModel.isCurrentUser {
                        
                        ProfileActionButton(
                            icon: viewModel.isFollowing ? "heart.fill" : "heart",
                            colour: viewModel.isFollowing ? .red : .black)
                        {
                            viewModel.isFollowing ?
                                viewModel.unFollow() : viewModel.follow()
                        }
                    }
                }
                .offset(y: 40)
                .padding(.horizontal, 20)
            }
            
            VStack(spacing: 10) {
                Text(user.username)
                    .font(.system(size: 26, weight: .semibold))
                Text(user.caption)
                    .font(.system(size: 15, weight: .light))
                    .lineSpacing(5)
                
                Text("www.google.com")
                    .padding(.vertical, 10)
                
                HStack {
                }
                .padding(.vertical, 10)
                
                HStack {
                    Text("Discounts")
                    Spacer()
                    Text("Discounts")
                    Spacer()
                    Text("Discounts")
                }
                Spacer()
            }
            .multilineTextAlignment(.center)
            .padding(.top, 50)
            .padding(.horizontal, 30)
        }
    }
}

struct ProfileActionButton: View {
    
    let icon: String
    var colour: Color? = .black
    let content: () -> ()
    
    var body: some View {
        Button(action: {
            content()
        }, label: {
            Image(systemName: icon)
                .font(.system(size: 26, weight: .regular))
                .foregroundColor(colour)
        })
        .padding(15)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.2), radius: 5, x: 0.0, y: 0.0)
    }
}
