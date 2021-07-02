//
//  PostCellViewModel.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 26/06/2021.
//

import SwiftUI
import FirebaseFirestore
import CoreLocation

extension PostCell {
    class ViewModel: ObservableObject {
        
        @Published var timeLeft: String = "0m ago"
        
        @Published var locationFromUser: String = "0.0mi"
        
        @Published var post: Post
        
        init(post: Post = .init(id: UUID().uuidString, accountHolderId: "", accountHolderName: "Burger Bar", accountHolderProfileImageURL: "burger", title: "Buy 1 MacBig and Get 1 FiletFish Free", backgroundImageURL: "burger", caption: "lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum", likes: 0, timestamp: Timestamp.init(), offerEnds: Timestamp(date: Date().addingTimeInterval(86400)), location: GeoPoint.init(latitude: 51.877510, longitude: 0.530000))){
            self.post = post
            self.timestampString()
            self.userDidLike()
            self.listenForLikes()
        }
        
        func listenForLikes(){
            
            guard let id = post.id else { return }
            
            COLLECTION_POSTS.document(id).addSnapshotListener { documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }
                
                guard let likes = data["likes"] else { return }
                self.post.likes = likes as! Int
                
            }
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
        
        func timestampString() {
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.second, .minute, .hour, .day]
            formatter.maximumUnitCount = 1
            formatter.unitsStyle = .abbreviated
            let date = formatter.string(from: Date(), to: post.offerEnds.dateValue()) ?? ""
            timeLeft = "\(date) left"
        }
        
        func userDidLike() {
            guard let id = post.id else { return }
            guard let currentUserId = AuthViewModel.shared.currentUser?.id else { return }
            COLLECTION_USERS.document(currentUserId).collection("user-likes").document(id).getDocument { snapshot, _ in
                guard let document = snapshot?.exists else { return}
                self.post.didLike = document
                
            }
            
            COLLECTION_POSTS.document(id).collection("post-likes").getDocuments { snapshot, _ in
                guard let likeCount = snapshot?.documents.count else { return }
                self.post.likes = likeCount
            }
        }
        
        func getLocationFromuser(_ location: CLLocation) -> String {
            let coord1 = CLLocation(latitude: self.post.location.latitude, longitude: self.post.location.longitude)
            
            let formatter = MeasurementFormatter()
            formatter.numberFormatter.maximumFractionDigits = 1
            
            let distance = Double(location.distance(from: coord1))
            
            let metresToMiles = Measurement(value: distance, unit: UnitLength.meters).converted(to: UnitLength.miles)
            
            return formatter.string(from: metresToMiles)
        }
        
    }
}
