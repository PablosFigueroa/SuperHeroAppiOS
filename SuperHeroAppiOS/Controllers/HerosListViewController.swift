//
//  HerosListViewController.swift
//  SuperHeroAppiOS
//
//  Created by Fernanda Fonseca on 8/12/20.
//  Copyright © 2020 Pablo Figueroa. All rights reserved.
//

import UIKit

class HerosListViewController: UIViewController {

    @IBOutlet weak var heroSearchBar: UISearchBar!
    @IBOutlet weak var cvHeros: UICollectionView!
    @IBOutlet weak var tvHeros: UITableView!
    let collectionCellIdentifier = "HeroCollectionCell"
    let tableCellIdentifier = "HeroTableCell"
    let network = NetworkManager()
    var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        names = network.getData()
        
    }
    
    func setupView(){
        cvHeros.delegate = self
        cvHeros.dataSource = self
        tvHeros.delegate = self
        tvHeros.dataSource = self
        tvHeros.rowHeight = 90
        
    }
    
    func Reload(){
        self.tvHeros.reloadData()
    }
    
    @IBAction func btnReload(_ sender: Any) {
        Reload()
    }
    
}


extension HerosListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(names.count)
        return names.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! HerosTableViewCell
        cell.lblHeroName.text = names[indexPath.row]
        print(names[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        Reload()
    }
}
