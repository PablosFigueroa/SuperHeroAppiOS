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
    private let group = DispatchGroup()
    
    func fetchHerosListData(total: Int, completion: @escaping () -> ()) {
        
        for i in stride(from: (total - 10), to: total, by: 1){
            self.group.enter()
                self.apiService.getHeros(id: i) { [weak self] (result) in
                switch result {
                case .success(let hero):
                    completion()
                    self?.herosList.append(hero)
                    self?.herosList.sort{
                        $0.name < $1.name
                    }
                    self?.group.leave()
                case .failure(let error):
                    print("Error processing json data: \(error)")
                    self?.group.leave()
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
