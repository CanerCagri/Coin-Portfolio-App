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
    
    let popUp = AddDeleteTableViewPopUpViewController()
    lazy var addDeleteViewModel =  AddDeleteViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        addDeleteViewModel.setDelegate(addDeleteVcProtocol: self)
        
        addDeleteViewModel.fetchItems()
    }
}

extension AddDeleteCoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListCell", for: indexPath) as! CoinListTableViewCell
        let symbolString = results[indexPath.row].symbol
        if symbolString.suffix(4) == "USDT"  {
            cell.configure(with: results, indexPath: indexPath)
        } else {
            results.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var symbolStr = results[indexPath.row].symbol
        symbolStr.insert("/", at: symbolStr.index(symbolStr.endIndex, offsetBy: -4))
        priceName = symbolStr
        let priceStringTemp = results[indexPath.row].price
        priceString = priceStringTemp.components(separatedBy: "00")[0]
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
