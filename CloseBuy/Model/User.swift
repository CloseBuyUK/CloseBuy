//
//  User.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 21/06/2021.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct User: Identifiable, Codable {
    let accountCreatedAt: Timestamp
    let profileImageURL: String
    let email: String
    let username: String
    let caption: String
    
    var isBusinessAccount: Bool? = false
    
    @DocumentID var id: String?
}
