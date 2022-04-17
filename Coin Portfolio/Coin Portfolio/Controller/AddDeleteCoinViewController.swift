//
//  AddDeleteCoinViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Alamofire

class AddDeleteCoinViewController: UIViewController  {

    @IBOutlet var coinListTableView: UITableView!
    
    @IBOutlet var myListLabel: UILabel!
    
    @IBOutlet var myListTable: UITableView!
    
    var decodedData = [CoinModel] ()
    var api = "https://api.binance.com/api/v3/ticker/price"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinListTableView.delegate = self
        coinListTableView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        if let url = URL(string: api) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                }
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        self.decodedData = try decoder.decode([CoinModel].self, from: safeData)
                        
                        DispatchQueue.main.async { 
                            self.coinListTableView.reloadData()
                        }
                    } catch {
                         print(error)
                    }
                }
            }
            task.resume()
        }
    }
}

extension AddDeleteCoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decodedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListCell", for: indexPath) as! CoinListTableViewCell
        let symbolString = decodedData[indexPath.row].symbol
        if symbolString.suffix(4) == "USDT"  {
            cell.coinName.text = decodedData[indexPath.row].symbol
            cell.coinPrice.text = decodedData[indexPath.row].price
            return cell
        } else {
            decodedData.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
        return UITableViewCell()
    }
}
