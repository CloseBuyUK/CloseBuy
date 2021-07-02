//
//  Post.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 22/06/2021.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Post: Identifiable, Codable {
    
    @DocumentID var id: String?
    
    let accountHolderId: String
    let accountHolderName: String
    let accountHolderProfileImageURL: String
        
    let title: String
    let backgroundImageURL: String
    let caption: String
    var likes: Int
    
    let timestamp: Timestamp
    let offerEnds: Timestamp
    
    let location: GeoPoint
    
    var didLike: Bool? = false
    
}
