//
//  HerosTableViewCell.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import UIKit

class HerosTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHero: UIImageView!
    @IBOutlet weak var lblHeroName: UILabel!
    
    
    func setCellWithValuesOf(_ hero:Hero) {
        updateUI(id: hero.id, name: hero.name, imageURL: hero.image.url)
    }

    func updateUI(id: String?, name: String?, imageURL: String?){
        self.lblHeroName.text = name
        
        guard let heroImageURL = URL(string: imageURL!) else {
            self.imgHero.image = UIImage(named: "noImageAvailable")
            return
        }
        
        self.imgHero.image = nil
        getImageDataFrom(url: heroImageURL)
    }
    
    private func getImageDataFrom(url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.imgHero.image = image
                }
            }
        }.resume()
    }
}
