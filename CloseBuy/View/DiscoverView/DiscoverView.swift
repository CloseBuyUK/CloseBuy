//
//  ExploreView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 21/06/2021.
//

import SwiftUI
import FirebaseFirestore

struct DiscoverView: View {
    
    @State var searchField: String = ""
    
    let post: Post = Post(accountHolderId: "", accountHolderName: "", accountHolderProfileImageURL: "coffee", title: "", backgroundImageURL: "coffee", caption: "", likes: 0, timestamp: Timestamp.init(), offerEnds: Timestamp.init(), location: GeoPoint.init(latitude: 51.877510, longitude: 0.530000))
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search...", text: $searchField)
            }
            .padding(10)
            .border(Color.black.opacity(0.25), width: 1)
            .padding(.horizontal, 15)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 10) {
                    ForEach(1...5, id: \.self) { post in
                        DiscoverCell()
                    }//MARK: ForEach
                }//MARK: LazyHStack
                .padding(.horizontal, 20)
            }
            .frame(height: 300)
            
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DiscoverView()
        }
    }
}
