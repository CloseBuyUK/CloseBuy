//
//  TabBarView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 21/06/2021.
//

import SwiftUI
import Firebase

struct TabBarView: View {
    
    let user: User
    
    var body: some View {
        TabView {
            HomeView(viewModel: HomeView.ViewModel(user: user)).tabItem {
                Image(systemName: "house")
                Text("Home")
            }.tag(1)
            DiscoverView().tabItem {
                Image(systemName: "magnifyingglass")
                Text("Explore")
            }.tag(2)
            MapView().tabItem {
                Image(systemName: "map")
                Text("Map")
            }.tag(3)
            ProfileView(viewModel: ProfileView.ViewModel(id: user.id!)).tabItem {
                Image(systemName: "person")
                Text("Account")
            }.tag(3)
        }
    }
}
