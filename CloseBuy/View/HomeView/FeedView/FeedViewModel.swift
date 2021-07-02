//
//  FeedViewModel.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 24/06/2021.
//

import Foundation
import FirebaseFirestore

extension FeedView {
    class ViewModel: ObservableObject {
        @Published var posts = [Post]()
        
        @Published var isEmpty: Bool = false
        
        let dataService: DataService
        
        init(dataService: DataService = AppDataService()){
            self.dataService = dataService
            fetchPosts()
            
        }
        
        func fetchStories(){
            
        }
        
        func fetchPosts(){
            dataService.fetchFollowing { accountId in
                if accountId.count >= 1 {
                    self.isEmpty = false
                    self.dataService.fetchPosts(accountId) { posts in
                        self.posts = posts
                    }
                }else{
                    self.isEmpty = true
                }
            }
        }
    }
    
    class AppDataService: DataService {
        
        func fetchPosts(_ idList: [String], completion: @escaping ([Post]) -> Void ){
            COLLECTION_POSTS.whereField("accountHolderId", in: idList).order(by: "timestamp", descending: true).getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                do {
                    try completion(documents.compactMap({ try $0.data(as: Post.self) }))
                }catch {
                    print("DEBUG: \(error.localizedDescription)")
                }
            }
        }
        
        func fetchFollowing(completion: @escaping ([String]) -> Void ){
            guard let id = AuthViewModel.shared.currentUser?.id else { return }
            
            COLLECTION_FOLLOWING.document(id).collection("user-following").getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                completion(documents.compactMap({ $0.reference.documentID }))
            }
        }
    }
}
