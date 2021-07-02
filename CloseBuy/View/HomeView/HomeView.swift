//
//  HomeView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 21/06/2021.
//

import SwiftUI
import FirebaseFirestore

extension HomeView {
    
    class ViewModel: ObservableObject {
        
        let user: User
        
        init(user: User = .init(accountCreatedAt: Timestamp.init(), profileImageURL: "", email: "", username: "", caption: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ", id: "")){
            self.user = user
        }
        
    }
}

struct HomeView: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init()){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .top) {
                    Rectangle()
                        .frame(height: 200)
                        .foregroundColor(Color.init(red: 94/255, green: 91/255, blue: 163/255))
                        .background(Color.blue)
                    VStack(alignment: .leading) {
                        
                        HStack(alignment: .center) {
                        
                            VStack(alignment: .leading) {
                                
                                Text("Hey there, \(viewModel.user.username)")
                                    .font(.custom("Poppins-Regular", size: 16))
                                
                                Text("Find Your Discount")
                                    .font(.custom("Poppins-Bold", size: 24))
                            }
                            
                            Spacer()
                            
                            Button(action: {}, label: {
                                Image(systemName: "gearshape.fill")
                                    .font(.system(size: 24))
                            })

                            
                            
                        }
                        
                        .padding(.horizontal, 20)
                        .foregroundColor(.white)
                        .padding(.top, 75)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            StoryView()
                                .padding(.horizontal, 15)
                                .padding(.vertical, 5)
                        }
                        .padding(.vertical, 5)
                        
                    }//MARK: VStack
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    FeedView()
                }
            }//MARK:VStack
            
        }//MARK: ScrollView
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
        
    }
}


struct HomeView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        HomeView()
    }
}
