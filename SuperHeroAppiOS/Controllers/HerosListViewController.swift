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
    var heroesGroup: Int = 1
    
    private var viewModel = HerosViewModel()
    var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadHerosData()
        
    }
    
    private func setupView(){
        cvHeros.delegate = self
        cvHeros.dataSource = self
        tvHeros.rowHeight = 90
    }
    
    private func loadHerosData() {
        viewModel.fetchHerosListData(group: heroesGroup) { [weak self] in
            self?.tvHeros.dataSource = self
            self?.cvHeros.dataSource = self
            self?.tvHeros.reloadData()
            self?.cvHeros.reloadData()
        }
        heroesGroup += 1
    }
}


extension HerosListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! HerosCollectionViewCell
        let hero = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(hero)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.numberOfRowsInSection(section: section)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! HerosTableViewCell
        let hero = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(hero)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}
