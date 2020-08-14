//
//  HeroDetailViewController.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    var heroToLoad: Hero?
    @IBOutlet weak var imgHero: UIImageView!
    @IBOutlet weak var lblHeroName: UILabel!
    
    @IBOutlet weak var progressINT: UIProgressView!
    @IBOutlet weak var progressSTR: UIProgressView!
    @IBOutlet weak var progressSPD: UIProgressView!
    @IBOutlet weak var progressEND: UIProgressView!
    @IBOutlet weak var progressPWR: UIProgressView!
    @IBOutlet weak var progressCOM: UIProgressView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProfile()
        setupProgressBars()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setProfile(){
        lblHeroName.text = heroToLoad?.name
        
        guard let heroImageURL = URL(string: (heroToLoad?.image.url)!) else {
            self.imgHero.image = UIImage(named: "noImageAvailable")
            return
        }
        self.imgHero.image = nil
        getImageDataFrom(url: heroImageURL)
    }
    
    func setupProgressBars(){
        progressINT.transform = progressINT.transform.scaledBy(x: 1, y: 10)
        progressINT.progress = checkForNulls(string: heroToLoad!.powerstats.strength) / 100
        progressSTR.transform = progressSTR.transform.scaledBy(x: 1, y: 10)
        progressSTR.progress = checkForNulls(string: heroToLoad!.powerstats.strength) / 100
        progressSPD.transform = progressSPD.transform.scaledBy(x: 1, y: 10)
        progressSPD.progress = checkForNulls(string: heroToLoad!.powerstats.speed) / 100
        progressEND.transform = progressEND.transform.scaledBy(x: 1, y: 10)
        progressEND.progress = checkForNulls(string: heroToLoad!.powerstats.durability) / 100
        progressPWR.transform = progressPWR.transform.scaledBy(x: 1, y: 10)
        progressPWR.progress = checkForNulls(string: heroToLoad!.powerstats.power) / 100
        progressCOM.transform = progressCOM.transform.scaledBy(x: 1, y: 10)
        progressCOM.progress = checkForNulls(string: heroToLoad!.powerstats.combat) / 100
    }
    
    func checkForNulls(string: String) -> Float{
        var num: Float
        
        if string != "null" {
            num = Float(string)!
        }else {
            num = 0
        }
        return num
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

