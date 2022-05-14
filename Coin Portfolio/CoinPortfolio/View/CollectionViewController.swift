//
//  CollectionViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Firebase


class CollectionViewController: UIViewController {
    
    @IBOutlet var totalBalance: UILabel!
    @IBOutlet var collectionTableView: UITableView!
    
    var coinName = ""
    var coinPrice = ""
    var coinQuantity = ""
    var coinId = ""
    var calculatedBalance : Double = 0
    
    let collectionViewM = CollectionViewModel()
    let collectionVc = CollectionVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionTableView.delegate = self
        collectionTableView.dataSource = self
        tableViewHeader()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        totalBalance.text = "$ 0.0"
        calculatedBalance = 0
        collectionViewM.output = self
        collectionViewM.fetchAllItems()
    }
    
    func tableViewHeader() {
        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: 276, height: 30))
        headerView.backgroundColor = .orange
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 276, height: 24))
        labelView.text = collectionVc.title
        labelView.textAlignment = .center
        headerView.addSubview(labelView)
        self.collectionTableView.tableHeaderView = headerView
    }
}

extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionViewM.numberOfInRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTableView.dequeueReusableCell(withIdentifier: collectionVc.cellIdentifier, for: indexPath) as! CollectionTableViewCell
        cell.configure(with: collectionViewM.postList, indexPath: indexPath)
        calculatedBalance += Double(collectionViewM.postList[indexPath.row].totalprice)!
        let result = String(format: "%.2f", ceil(calculatedBalance * 100) / 100)
        totalBalance.text = "$ \(String(result))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coinId = collectionViewM.postList[indexPath.row].id
        coinName = collectionViewM.postList[indexPath.row].coinname
        coinQuantity = String(collectionViewM.postList[indexPath.row].coinquantity)
        let apiPrice = collectionViewM.postList[indexPath.row].totalprice
        let apiPriceResult = apiPrice.components(separatedBy: "0000")
        if apiPriceResult[0].last != "." {  // Price checking , if price end with . after result add 0
            coinPrice = apiPriceResult[0]
            
        } else {
            let last = "\(apiPriceResult[0])0"
            coinPrice = last
        }
        performSegue(withIdentifier: "toCollectionPopup", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCollectionPopup" {
            let destination = segue.destination as! CollectionViewPopup
            destination.delegate = self
            destination.coinID = coinId
            destination.coinName = coinName
            destination.coinPrice = coinPrice
            destination.coinQuantity = coinQuantity
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let coinPrice = Double(collectionViewM.postList[indexPath.row].totalprice)
            let result = calculatedBalance - coinPrice!
            let calculate = String(format: "%.2f", ceil(result * 100) / 100)
            totalBalance.text = "$ \(calculate)"
            collectionViewM.postDeleteDocument(selectedCoin: collectionViewM.postList[indexPath.row].id)
            collectionViewM.postList.remove(at: indexPath.row)
            collectionTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
}

extension CollectionViewController: CollectionViewModelOutput {
    func updateView(valuePostList: [PostModel]) {
        collectionViewM.postList = valuePostList
        collectionTableView.reloadData()
    }
}

extension CollectionViewController : CollectionViewPopupProtocol {
    func settingsUpdated() {
        tabBarController?.selectedIndex = 1
    }
}
