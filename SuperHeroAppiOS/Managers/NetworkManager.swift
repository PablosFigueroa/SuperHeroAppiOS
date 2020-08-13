//
//  API.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let userToken = "10156112965520834"
    let baseURL = "https://superheroapi.com/api/"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getSuperHeroes( for name: String, page: Int, completed> @escaping ())
}
