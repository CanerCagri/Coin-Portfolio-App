//
//  AddDeleteCoinViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit


class AddDeleteCoinViewController: UIViewController  {
    @IBOutlet var coinListTableView: UITableView!
    
    var priceName = ""
    var priceString = ""
    var filteredCoins : [CoinModel] = []
    let popUp = AddDeleteTableViewPopUpViewController()
    let searchController = UISearchController()
    let addDeleteViewM = AddDeleteViewModel()
    let addDeleteVC = AddDeleteVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadConfig()
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addDeleteViewM.output = self
        addDeleteViewM.fetchItems()
    }
    
    @objc func refreshData() -> Void {
        addDeleteViewM.fetchItems()
    }
    
    func loadConfig() {
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        title = addDeleteVC.title
        
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
        filteredCoins.removeAll()
        return addDeleteViewM.coinListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: addDeleteVC.cellIdentifier , for: indexPath) as! CoinListTableViewCell
        
        let coinResult : CoinModel!
        if searchController.isActive {
            
            coinResult = filteredCoins[indexPath.row]
            let symbolString = coinResult.symbol
            if symbolString.suffix(4) == addDeleteVC.symbolSuffixUsdt {
                if coinResult.lastPrice != addDeleteVC.firstlastPriceFilter && coinResult.lastPrice != addDeleteVC.secondlastPriceFilter {
                    cell.configure(with: filteredCoins, indexPath: indexPath)
                } else {
                    filteredCoins.remove(at: indexPath.row)
                    tableView.reloadData()
                }
            } else {
                filteredCoins.remove(at: indexPath.row)
                tableView.reloadData()
            }
        } else {
            filteredCoins.removeAll()
            coinResult = addDeleteViewM.coinListArray[indexPath.row]
            let symbolString = coinResult.symbol
            if symbolString.suffix(4) == addDeleteVC.symbolSuffixUsdt {
                if coinResult.lastPrice != addDeleteVC.firstlastPriceFilter && coinResult.lastPrice != addDeleteVC.secondlastPriceFilter {
                    cell.configure(with: addDeleteViewM.coinListArray, indexPath: indexPath)
                } else {
                    addDeleteViewM.coinListArray.remove(at: indexPath.row)
                    tableView.reloadData()
                }
            } else {
                addDeleteViewM.coinListArray.remove(at: indexPath.row)
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
            coinResult = addDeleteViewM.coinListArray[indexPath.row]
        }
        var symbolStr = coinResult.symbol
        symbolStr.insert("/", at: symbolStr.index(symbolStr.endIndex, offsetBy: -4))
        priceName = symbolStr
        let apiPrice = coinResult.lastPrice
        let result = apiPrice.components(separatedBy: addDeleteVC.lastPriceSeperator)
        if result[0].last != "." {  // Price checking , if price end with . after result add 0
            priceString = result[0]
        } else {
            let last = "\(result[0])0"
            priceString = last
        }
        performSegue(withIdentifier: addDeleteVC.popUpIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == addDeleteVC.popUpIdentifier {
            let destination = segue.destination as! AddDeleteTableViewPopUpViewController
            destination.coinName = priceName
            destination.coinPrice = priceString
        }
    }
}

extension AddDeleteCoinViewController : UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let searchText = searchBar.text!
        filterForSearch(searchText: searchText)
    }
    
    func filterForSearch(searchText: String ) {
        filteredCoins = addDeleteViewM.coinListArray.filter {
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

extension AddDeleteCoinViewController: AddDeleteViewModelOutput {
    func updateView(valuePostList: [CoinModel]) {
        addDeleteViewM.coinListArray = valuePostList
        coinListTableView.reloadData()
    }
}
