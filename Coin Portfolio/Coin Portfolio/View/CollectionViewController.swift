//
//  CollectionViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet var totalBalance: UILabel!
    @IBOutlet var collectionTableView: UITableView!
    
    var calculatedBalance : Double = 0
  
    let collectionViewModel = CollectionViewModel()
    
    var service = Service()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionTableView.delegate = self
        collectionTableView.dataSource = self
        collectionTableView.reloadData()
        tableViewHeader()
        
        collectionViewModel.fetchData { data in
            DispatchQueue.main.async {
                self.collectionViewModel.post = data
                self.collectionTableView.reloadData()
               
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func tableViewHeader() {
        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: 276, height: 30))
        headerView.backgroundColor = .orange
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 276, height: 24))
        labelView.text = "YOUR COIN LIST"
        labelView.textAlignment = .center
        headerView.addSubview(labelView)
        self.collectionTableView.tableHeaderView = headerView
    }
}

extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(collectionViewModel.post.count)
        return collectionViewModel.post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CollectionTableViewCell
        cell.configure(with: collectionViewModel.post, indexPath: indexPath)
        calculatedBalance += Double(collectionViewModel.post[indexPath.row].totalprice)!
        totalBalance.text = "$ \(String(calculatedBalance))"
        return cell
    }
}
