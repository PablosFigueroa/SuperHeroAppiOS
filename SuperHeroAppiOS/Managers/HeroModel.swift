//
//  HeroJSONModel.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import Foundation

struct HerosData: Codable {
    var response: String
    var results_for: String
    var results: [Hero]?
    
    enum CodingKeys: String, CodingKey {
    case response = "response"
    case results_for = "results-for"
    case results
    }
}

struct Hero: Codable {
    var id: String
    var name: String
    var powerstats: PowerStats
    var image: Image
}

struct Image: Codable {
    var url: String
}
