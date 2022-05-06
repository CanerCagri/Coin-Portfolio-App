//
//  CollectionViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Firebase

protocol CollectionViewControllerProtocol {
    func saveDatas(values : [PostModel])
}

class CollectionViewController: UIViewController {
    
    @IBOutlet var totalBalance: UILabel!
    @IBOutlet var collectionTableView: UITableView!
    
    var calculatedBalance : Double = 0
    
    let collectionViewModel = CollectionViewModel()
    let collectionVc = CollectionVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionTableView.delegate = self
        collectionTableView.dataSource = self
        collectionTableView.reloadData()
        tableViewHeader()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        collectionViewModel.setDelegate(collectionVcProtocol: self)
        collectionViewModel.fetchAllItems()
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
        return collectionViewModel.postList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTableView.dequeueReusableCell(withIdentifier: collectionVc.cellIdentifier, for: indexPath) as! CollectionTableViewCell
        cell.configure(with: collectionViewModel.postList, indexPath: indexPath)
        calculatedBalance += Double(collectionViewModel.postList[indexPath.row].totalprice)!
        totalBalance.text = "$ \(String(calculatedBalance))"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            collectionViewModel.postDeleteDocument(selectedCoin: collectionViewModel.postList[indexPath.row].id)
            collectionViewModel.postList.remove(at: indexPath.row)
            collectionTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
        }
    }
}

extension CollectionViewController: CollectionViewControllerProtocol {
    func saveDatas(values: [PostModel]) {
        collectionViewModel.postList = values
        collectionTableView.reloadData()
    }
}
