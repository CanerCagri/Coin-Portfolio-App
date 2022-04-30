//
//  AddDeleteCoinViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

protocol AddDeleteCoinViewControllerProtocol {
    func saveDatas(values: [CoinModel])
}

class AddDeleteCoinViewController: UIViewController  {
    
    @IBOutlet var coinListTableView: UITableView!
    
    var priceName = ""
    var priceString = ""
    lazy var results : [CoinModel] = []
    var filteredCoins : [CoinModel] = []
    let popUp = AddDeleteTableViewPopUpViewController()
    lazy var addDeleteViewModel =  AddDeleteViewModel()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadConfig()
     
    }
    
    func loadConfig() {
        
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        addDeleteViewModel.setDelegate(addDeleteVcProtocol: self)
        addDeleteViewModel.fetchItems()
        
        title = "Coin List"
        
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
   
}

extension AddDeleteCoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchController.isActive) {
            return filteredCoins.count
        }
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListCell", for: indexPath) as! CoinListTableViewCell
        
        let coinResult : CoinModel!
        
        if searchController.isActive {
            coinResult = filteredCoins[indexPath.row]
            let symbolString = coinResult.symbol
            if symbolString.suffix(4) == "USDT"  {
                cell.configure(with: filteredCoins, indexPath: indexPath)
            } else {
                filteredCoins.remove(at: indexPath.row)
                tableView.reloadData()
            }
        } else {
            coinResult = results[indexPath.row]
            let symbolString = coinResult.symbol
            if symbolString.suffix(4) == "USDT"  {
                cell.configure(with: results, indexPath: indexPath)
            } else {
                results.remove(at: indexPath.row)
                tableView.reloadData()
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let coinResult : CoinModel!
        
        if searchController.isActive {
            coinResult = filteredCoins[indexPath.row]
        } else {
            coinResult = results[indexPath.row]
        }
        
        var symbolStr = coinResult.symbol
        symbolStr.insert("/", at: symbolStr.index(symbolStr.endIndex, offsetBy: -4))
        priceName = symbolStr
        priceString = coinResult.lastPrice
        performSegue(withIdentifier: "toPopup", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPopup" {
            let destination = segue.destination as! AddDeleteTableViewPopUpViewController
            destination.coinName = priceName
            destination.coinPrice = priceString
        }
    }
}

extension AddDeleteCoinViewController: AddDeleteCoinViewControllerProtocol {
    func saveDatas(values: [CoinModel]) {
        results = values
        coinListTableView.reloadData()
    }
}

extension AddDeleteCoinViewController : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        filterForSearch(searchText: searchText)
        
    }
    
    func filterForSearch(searchText: String ) {
        filteredCoins = results.filter {
            coin in
            if (searchController.searchBar.text != "") {
                let searchTextMatch = coin.symbol.lowercased().contains(searchText.lowercased())
                return searchTextMatch
            } else {
                return true
            }
        }
        coinListTableView.reloadData()
    }
}
