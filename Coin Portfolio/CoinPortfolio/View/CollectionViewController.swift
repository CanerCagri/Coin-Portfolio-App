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
    
    let notificationListener = "notification"
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(change), name: NSNotification.Name(notificationListener), object: nil)
    }
    
    @objc func change() {
        self.tabBarController?.selectedIndex = 1
    }
    
    func tableViewHeader() {
        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: 276, height: 30))
        headerView.backgroundColor = .orange
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 50, y: 5, width: 276, height: 24))
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
       
        
        calculatedBalance = 0
        if indexPath.row == collectionViewM.postList.count - 1 {
            for index in 0..<collectionViewM.postList.count {
                calculatedBalance += Double(collectionViewM.postList[index].totalprice)!
                let result = String(calculatedBalance)
                totalBalance.text = "$ \(String(result))"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coinId = collectionViewM.postList[indexPath.row].id
        coinName = collectionViewM.postList[indexPath.row].coinname
        coinQuantity = String(collectionViewM.postList[indexPath.row].coinquantity)
        let apiPrice = collectionViewM.postList[indexPath.row].totalprice
        let apiPriceResult = apiPrice.components(separatedBy: "000")
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
            collectionViewM.postDeleteDocument(selectedCoin: collectionViewM.postList[indexPath.row].id)
            collectionViewM.postList.remove(at: indexPath.row)
            collectionTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
            if collectionViewM.postList.count != 0 {
                calculatedBalance = Double(calculate)!
                totalBalance.text = "$ \(calculate)"

            } else {
                calculatedBalance = 0
                totalBalance.text = "$ 0.0"
            }
        }
    }
}

extension CollectionViewController: CollectionViewModelOutput {
    func updateView(valuePostList: [PostModel]) {
        collectionViewM.postList = valuePostList
        collectionTableView.reloadData()
    }
}


