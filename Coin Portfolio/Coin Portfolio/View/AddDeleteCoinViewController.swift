//
//  AddDeleteCoinViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

protocol AddDeleteCoinViewControllerProtocol {
    func saveDatas(vales: [CoinModel])
}

class AddDeleteCoinViewController: UIViewController  {

    @IBOutlet var coinListTableView: UITableView!

    var priceName = ""
    var priceString = ""
    
    let popUp = AddDeleteTableViewPopUpViewController()
    var service = Service()
    var addDeleteViewModel = AddDeleteViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        
        service.loadCoins { data in
            self.addDeleteViewModel.decodedData = data!
            
            DispatchQueue.main.async {
                self.coinListTableView.reloadData()
            }
        }
    }
}

extension AddDeleteCoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addDeleteViewModel.decodedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListCell", for: indexPath) as! CoinListTableViewCell
        let symbolString = addDeleteViewModel.decodedData[indexPath.row].symbol
        if symbolString.suffix(4) == "USDT"  {
            cell.configure(with: addDeleteViewModel.decodedData, indexPath: indexPath)
        } else {
            addDeleteViewModel.decodedData.remove(at: indexPath.row)
            tableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var symbolStr = addDeleteViewModel.decodedData[indexPath.row].symbol
        symbolStr.insert("/", at: symbolStr.index(symbolStr.endIndex, offsetBy: -4))
        priceName = symbolStr
        let priceStringTemp = addDeleteViewModel.decodedData[indexPath.row].price
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
    func saveDatas(vales: [CoinModel]) {
        <#code#>
    }
    
    
}
