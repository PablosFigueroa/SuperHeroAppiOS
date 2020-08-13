//
//  HeroJSONModel.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import Foundation

struct Hero: Codable {
    let id: String
    let name: String
    let powerstats: [String]
    let imageUrl: String
}
