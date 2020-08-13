//
//  HeroJSONModel.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import Foundation

struct HerosData: Codable {
    var heros: [Hero]
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
