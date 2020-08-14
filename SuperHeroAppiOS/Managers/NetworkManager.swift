//
//  API.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private var dataTask: URLSessionDataTask?
    let userToken = "10156112965520834/"
    let baseURL = "https://superheroapi.com/api.php/"
    
    
    func getHeros(id: Int, completion: @escaping (Result<Hero, Error>) -> Void){
        guard let url = URL(string: baseURL + userToken + String(id)) else {
            fatalError("URL guard FAILED")
        }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Hero.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    
    func getHeroByName(name: String, completion: @escaping (Result<HerosData, Error>) -> Void){
        let trimName = name.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: baseURL + userToken + "search/" + trimName) else {
            fatalError("URL guard FAILED")
        }
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(HerosData.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
        
    }
}
