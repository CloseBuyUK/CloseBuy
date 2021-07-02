//
//  PostViewModel.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 30/06/2021.
//

import Foundation

extension PostView {
    class ViewModel: ObservableObject {
        @Published var post: Post
        
        init(post: Post){
            self.post = post
        }
        
        func likePost(){
            self.post.didLike = true
            let currentLikes = self.post.likes
            guard let id = post.id else { return }
            UserService.likePost(postId: id, likes: currentLikes) { error in
                if let _ = error {
                    self.post.didLike = false
                    return
                }
            }
        }
        
        func unlikePost(){
            self.post.didLike = false
            let currentLikes = self.post.likes
            guard let id = post.id else { return }
            UserService.unLikePost(postId: id, likes: currentLikes) { error in
                if let _ = error {
                    self.post.didLike = true
                    return
                }
            }
        }
        
        func userDidLike() {
            guard let id = post.id else { return }
            guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
            COLLECTION_USERS.document(currentUserId).collection("user-likes").document(id).getDocument { snapshot, _ in
                guard let document = snapshot?.exists else { return}
                self.post.didLike = document
            }
        }
        
        var timestampString: String {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.second, .minute, .hour, .day]
            formatter.maximumUnitCount = 1
            formatter.unitsStyle = .abbreviated
            let date = formatter.string(from: Date(), to: post.offerEnds.dateValue()) ?? ""
            return "\(date) left"
        }
        
    }
}
