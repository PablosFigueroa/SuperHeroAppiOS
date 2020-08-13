//
//  HerosViewModel.swift
//  SuperHeroAppiOS
//
//  Created by Pablo Figueroa on 13/08/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import Foundation

class HerosViewModel {
    
    private var apiService = NetworkManager()
    private var herosList: [Hero] = []
    var groupNumber = 1
    
    
    func fetchHerosListData(group: Int, completion: @escaping () -> ()) {
        
        for i in stride(from: group, to: 11, by: 1){
            
            apiService.getHeros(id: i) { [weak self] (result) in
            
            switch result {
            case .success(let hero):
                self?.herosList.append(hero)
                completion()
            case .failure(let error):
                // Something is wrong with the JSON file or the model
                print("Error processing json data: \(error)")
                }
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if herosList.count != 0 {
            return herosList.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> Hero {
        return herosList[indexPath.row]
    }
}
