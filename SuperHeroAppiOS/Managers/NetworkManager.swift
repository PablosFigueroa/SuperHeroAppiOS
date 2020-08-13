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
    let userToken = "10156112965520834/"
    let baseURL = "https://superheroapi.com/api.php/"
    
    
    func getData() -> [String] {
        let urls = [baseURL + userToken + String(1),
                    baseURL + userToken + String(2),
                    baseURL + userToken + String(3),
                    baseURL + userToken + String(4),
                    baseURL + userToken + String(5),
                    baseURL + userToken + String(6),
                    baseURL + userToken + String(7),
                    baseURL + userToken + String(8),
                    baseURL + userToken + String(9),
                    baseURL + userToken + String(10),
        ]
        
        let group = DispatchGroup()
        var heros: [String] = []
        
        for url in urls {
            guard let url = URL(string: url) else{
                continue
            }
            print(url)
            group.enter()
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler:  {data, response, error in
                
                defer {
                    group.leave()
                }
                
                let decoder = JSONDecoder()
                do {
                    let hero = try decoder.decode(Hero.self, from: data!)
                    heros.append(hero.name)
                    print(heros)
                }
                catch {
                    print("ERROR IN JSON")
                }
            })
            task.resume()
        }
        group.notify(queue: .main, execute: {
            print("Done with jsons")
             
        })
        return heros
    }
    
    
    
}
