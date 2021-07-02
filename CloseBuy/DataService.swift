//
//  DataService.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 24/06/2021.
//

import Foundation

protocol DataService {
    func fetchPosts(_ idList: [String], completion: @escaping ([Post]) -> Void)
    func fetchFollowing(completion: @escaping ([String]) -> Void)
}
