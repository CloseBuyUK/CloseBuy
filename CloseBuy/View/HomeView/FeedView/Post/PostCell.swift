//
//  FeedCell.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 21/06/2021.
//

import SwiftUI
import FirebaseFirestore

struct PostCell: View {
    
    @StateObject var viewModel: ViewModel
    
    @StateObject var locationManager = LocationManager()
    
    var didLike: Bool { viewModel.post.didLike ?? false }
    
    init(viewModel: ViewModel = .init()){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        if let location = locationManager.location {
            
            VStack(alignment: .leading, spacing: 0) {
                
                //MARK: UpperHalf
                
                ZStack(alignment: .bottomLeading) {
                    BackgroundImage(viewModel.post.backgroundImageURL)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    HStack(alignment: .bottom, spacing: 8) {
                        VStack(alignment: .leading, spacing: 0) {
                            NavigationLink(
                                destination: ProfileView(viewModel: ProfileView.ViewModel(id: viewModel.post.accountHolderId)),
                                label: {
                                    ProfileImage(viewModel.post.accountHolderProfileImageURL)
                                })
                                .buttonStyle(FlatLinkStyle())
                            Spacer()
                        }
                        
                        Spacer()
                        
                        VStack {
                            
                            PostActionButton(icon: didLike ? "heart.fill" :  "heart", colour: didLike ? .red : .black) {
                                didLike ? viewModel.unlikePost() : viewModel.likePost()
                            }
                            
                            PostActionButton(icon: "qrcode.viewfinder") {
                                print("Display QRCode")
                            }
                        }
                    }//MARK: HStack
                    .shadow(color: .black.opacity(0.15), radius: 2, x: 0.0, y: 0.0)
                    .padding(7)
                }
                .frame(height: 150)
                .clipped()
                
                //MARK: Lower Half Post
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    
                    HStack(alignment: .center, spacing: 6) {
                        DetailView(icon: "map", text: viewModel.getLocationFromuser(location))
                        Circle().frame(width: 2, height: 2)
                        DetailView(icon: didLike ? "heart.fill" : "heart",
                                   text: "\(viewModel.post.likes) likes")
                        Circle().frame(width: 2, height: 2)
                        DetailView(icon: "clock", text: viewModel.timeLeft)
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "ellipsis")
                                .font(.system(size: 24))
                        })
                    }
                    .foregroundColor(.gray)
                    .padding(.top, 10)

                        Description(accountHolderName: viewModel.post.accountHolderName, description: viewModel.post.caption)
                            .lineSpacing(3)
                            .foregroundColor(Color.init(red: 64/255, green: 64/255, blue: 64/255))
                    .padding(.vertical, 8)
                }
                .padding(.horizontal, 15)
                
            }//MARK: VStack
            .padding(.bottom, 10)
            .onAppear(perform: {
                viewModel.userDidLike()
            })
        }
        else{
            ProgressView()
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell()
            .previewLayout(.sizeThatFits)
            .padding()
            .background(Color.gray.opacity(0.1))
    }
}

struct PostActionButton: View {
    let icon: String
    var colour: Color? = .black
    let action: () -> ()
    
    var body: some View {
        Button(action: {action()}, label: {
            Image(systemName: icon)
        })
        .font(.system(size: 21))
        .foregroundColor(colour)
        .padding(10)
        .background(Color.white)
        .clipShape(Circle())
    }
}

struct DetailView: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 3) {
            Image(systemName: icon)
            Text(text)
        }
        .font(.system(size: 12, weight: .regular))
        .foregroundColor(.gray)
    }
}

struct BackgroundImage: View {
    
    let imageURL: String
    
    init(_ imageURL: String){
        self.imageURL = imageURL
    }
    
    var body: some View {
        ZStack {
            Image(imageURL)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            Color.clear
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .black]), startPoint: .top, endPoint: .bottom))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct ProfileImage: View {
    
    let imageURL: String
    
    init(_ imageURL: String){
        self.imageURL = imageURL
    }
    
    var body: some View {
        Image(imageURL)
            .resizable()
            .frame(width: 45, height: 45)
            .clipShape(Circle())
            .clipped()
            .shadow(color: .black.opacity(0.25), radius: 2, x: 0.0, y: 0.0)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2.5)
            )
    }
}

struct Description: View {
    
    let accountHolderName: String
    let description: String
    
    var body: some View {
        Text(accountHolderName).font(.system(size: 15, weight: .semibold, design: .rounded)) +
            Text(" \(description)")
            .font(.system(size: 16, weight: .light, design: .rounded))
    }
}

struct Seperator: View {
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width/1.5, height: 1)
            .foregroundColor(.gray.opacity(0.1))
            .background(Color.gray.opacity(0.1))
    }
}
