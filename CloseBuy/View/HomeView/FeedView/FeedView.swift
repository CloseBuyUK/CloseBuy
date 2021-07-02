//
//  FeedView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 20/06/2021.
//

import SwiftUI

struct FeedView: View {
    
    @Namespace var namespace
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init()){
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if !viewModel.isEmpty {
            LazyVStack(spacing: 0) {
                ForEach(viewModel.posts) { post in
                    NavigationLink(
                        destination: PostView(viewModel: PostView.ViewModel(post: post)),
                        label: {
                            PostCell(viewModel: PostCell.ViewModel(post: post))
                                .padding(0)
                                .background(Color.white)
                        })
                        .cornerRadius(15)
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            }//MARK: LazyVStack
        }else{
            VStack(alignment: .center) {
                Text("Feed is empty")
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    
    static var previews: some View {
        ScrollView(.vertical, showsIndicators: false) {
            FeedView()
                .previewLayout(.sizeThatFits)
        }
        .background(Color.gray.opacity(0.1))
    }
}
