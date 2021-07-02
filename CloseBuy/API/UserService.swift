//
//  UserService.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 27/06/2021.
//

import Firebase
import FirebaseFirestore

struct UserService {
    
    //MARK: Like Post
    static func likePost(postId: String, likes: Int, completion: ((Error?) -> Void)?){
        guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        COLLECTION_POSTS.document(postId).collection("post-likes")
            .document(currentUserId).setData([:]) { _ in
                COLLECTION_USERS.document(currentUserId).collection("user-likes").document(postId).setData([:]) { _ in
                    COLLECTION_POSTS.document(postId).updateData(["likes": likes+1], completion: completion)
                }
            }
    }
    
    //MARK: Unlike Post
    static func unLikePost(postId: String, likes: Int, completion: ((Error?) -> Void)?){
        guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        COLLECTION_POSTS.document(postId).collection("post-likes")
        .document(currentUserId).delete() { _ in
            COLLECTION_USERS.document(currentUserId).collection("user-likes").document(postId).delete { _ in
                COLLECTION_POSTS.document(postId).updateData(["likes": likes-1], completion: completion)
            }
        }
    }
    
    //MARK: Follow user
    static func follow(userId: String, completion: ((Error?) -> Void)?){
        guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        
        COLLECTION_FOLLOWING.document(currentUserId)
            .collection("user-following").document(userId).setData([:]) { _ in
                COLLECTION_FOLLOWERS.document(userId).collection("user-followers").document(currentUserId)
                    .setData([:], completion: completion)
            }
    }
    
    //MARK: Unfollow user
    static func unfollow(userId: String, completion: ((Error?) -> Void)?) {
        guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        
        COLLECTION_FOLLOWING.document(currentUserId)
            .collection("user-following").document(userId).delete() { _ in
                COLLECTION_FOLLOWERS.document(userId)
                    .collection("user-followers").document(currentUserId).delete(completion: completion)
            }
    }
    
    static func fetchUser(userId: String, completion: @escaping (User) -> Void ){
        COLLECTION_USERS.document(userId).getDocument { (document, error) in
            if let document = document {
                guard let user = try? document.data(as: User.self) else {
                    print("Can't convert data")
                    return
                }
                
                completion(user)
            }
        }
    }
    
    static func isUserFollowing(userId: String, completion: @escaping (Bool) -> Void) {
        guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
        COLLECTION_FOLLOWING.document(currentUserId).collection("user-following").document(userId).getDocument { (document, error) in
            if let document = document, document.exists {
                completion(true)
            }
        }
    }
}
