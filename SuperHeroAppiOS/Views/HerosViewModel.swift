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
    var herosList: [Hero] = []
    
    
    func fetchHerosListData(total: Int, completion: @escaping () -> ()) {
        
            for i in stride(from: (total - 10), to: total, by: 1){
                self.apiService.getHeros(id: i) { [weak self] (result) in
                switch result {
                case .success(let hero):
                    completion()
                    self?.herosList.append(hero)
                case .failure(let error):
                    print("Error processing json data: \(error)")
                }
            }
        }
        
    }
    
    func numberOfRowsInCollection(section: Int) -> Int {
        if herosList.count != 0 {
            return herosList.count
        }
        return 0
    }
    
    func cellForRowAtCollection (indexPath: IndexPath) -> Hero {
        
        return herosList[indexPath.row]
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
