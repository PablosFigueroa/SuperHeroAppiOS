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
    private var apiService = NetworkManager()
    let collectionCellIdentifier = "HeroCollectionCell"
    let tableCellIdentifier = "HeroTableCell"
    var heroesTotal: Int = 11
    var heroToDetail: Hero? = nil
    var loadMoreHeroes = false
    private var viewModel = HerosViewModel()
    var names: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadHerosData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    private func setupView(){
        cvHeros.delegate = self
        tvHeros.delegate = self
        heroSearchBar.delegate = self
        tvHeros.rowHeight = 90
        heroSearchBar.searchTextField.textColor = .white
    }
    
    private func loadHerosData() {
        
        viewModel.fetchHerosListData(total: heroesTotal) { [weak self] in
            self?.tvHeros.dataSource = self
            self?.cvHeros.dataSource = self
            self?.tvHeros.reloadData()
            self?.cvHeros.reloadData()
            
        }
        heroesTotal += 10
    }
    
    private func loadMoreHeros() {
        loadMoreHeroes = true
        print("empieza a cargar mas heroees")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.viewModel.fetchHerosListData(total: self.heroesTotal) { [weak self] in
            self?.loadMoreHeroes = false
            self?.tvHeros.reloadData()
            self?.cvHeros.reloadData()
            }
        })
        heroesTotal += 10
    }
    
    private func searchName() {
        self.apiService.getHeroByName(name: self.heroSearchBar.text!){ [weak self] (result) in
            switch result {
            case .success(let hero):
                self?.heroToDetail = hero.results![0]
                self?.performSegue(withIdentifier: "DetailSegue", sender: self)
            case .failure(let error):
                print("Error processing json data: \(error)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue"{
            let detailView = segue.destination as! HeroDetailViewController
            detailView.heroToLoad = heroToDetail!
        }
    }
}


extension HerosListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchName()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifier, for: indexPath) as! HerosCollectionViewCell
        let hero = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(hero)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        let selectedHero = viewModel.cellForRowAt(indexPath: indexPath)
        heroToDetail = selectedHero
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
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
        
        let selectedHero = viewModel.cellForRowAt(indexPath: indexPath)
        heroToDetail = selectedHero
        self.performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !loadMoreHeroes{
                
                print("load more heroeees")
                loadMoreHeros()
            }
        }
    }
        
}
