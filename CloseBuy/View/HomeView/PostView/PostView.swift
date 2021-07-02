//
//  PostView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 28/06/2021.
//

import SwiftUI
import FirebaseFirestore

extension UINavigationController {
    
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
    
}

struct PostView: View {
    
    @StateObject var viewModel: ViewModel
    
    var didLike: Bool { viewModel.post.didLike ?? false }
    
    init(viewModel: ViewModel = .init(post: .init(id: UUID().uuidString, accountHolderId: "", accountHolderName: "Burger Bar", accountHolderProfileImageURL: "burger", title: "Buy 1 MacBig and Get 1 FiletFish Free", backgroundImageURL: "burger", caption: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum", likes: 2, timestamp: Timestamp.init(), offerEnds: Timestamp(date: Date().addingTimeInterval(86400)), location: GeoPoint.init(latitude: 51.877510, longitude: 0.530000)))){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading) {
                    Image(viewModel.post.backgroundImageURL)
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 250, alignment: .bottom)
                            .clipped()
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(alignment: .top, spacing: 15) {
                            Image(viewModel.post.accountHolderProfileImageURL)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 2) {
                                
                                Text("\(viewModel.post.accountHolderName) has a discount")
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundColor(.gray)
                                
                                Text(viewModel.post.title)
                                    .font(.system(size: 23, weight: .semibold))
                                    .foregroundColor(.black)
                                    .lineSpacing(3)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                        .padding(.bottom, 15)
                        
                        Text(viewModel.post.caption)
                            .font(.system(size: 16, weight: .light))
                            .lineSpacing(8)
                    }
                    .padding(15)
                }
                .frame(minHeight: 0, maxHeight: .infinity)
            }
            
            HStack {
                ActionButton(icon: didLike ? "heart.fill" : "heart", colour: didLike ? .red : .white ){
                    didLike ? viewModel.unlikePost() : viewModel.likePost()
                }
                
                ActionButton(icon: "qrcode.viewfinder") {
                    
                }
                VStack {
                    Text("Expires ") +
                        Text("\(viewModel.post.offerEnds.dateValue(), style: .date)")
                        .bold()
                }
                .font(.system(size: 18))
                .padding(20)
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(25)
            }
            .padding(5)
        }
        .onAppear(perform: viewModel.userDidLike )
        .navigationBarTitle("\(viewModel.post.title)", displayMode: .inline)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

struct ActionButton: View {
    
    let icon: String
    var colour: Color = .white
    
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .medium))
            }
        })
        .padding(20)
        .background(Color.black)
        .foregroundColor(colour.opacity(0.85))
        .cornerRadius(25)
    }
}
