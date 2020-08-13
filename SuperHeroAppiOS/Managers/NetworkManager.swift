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
    private var heroArray = [Hero]()
    private var loading = true
    
    func getHeros(id: Int, completion: @escaping (Result<Hero, Error>) -> Void){
        
        guard let url = URL(string: baseURL + userToken + String(id)) else {
            fatalError("URL guard FAILED")
        }
        print(url)
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Hero.self, from: data)
                
                // Back to the main thread
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
