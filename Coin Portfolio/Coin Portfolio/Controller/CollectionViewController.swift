//
//  CollectionViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Firebase
import CoreMedia

class CollectionViewController: UIViewController {
    
    @IBOutlet var collectionTableView: UITableView!
    
    var postArray = [PostModel] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionTableView.delegate = self
        collectionTableView.dataSource = self
        
        tableViewHeader()
        fetchData()
    }
    
    func tableViewHeader() {
        let headerView: UIView = UIView.init(frame: CGRect(x: 1, y: 50, width: 276, height: 30))
        headerView.backgroundColor = .red
        let labelView: UILabel = UILabel.init(frame: CGRect(x: 4, y: 5, width: 276, height: 24))
        labelView.text = "YOUR COIN LIST"
        labelView.textAlignment = .center
        
        headerView.addSubview(labelView)
        self.collectionTableView.tableHeaderView = headerView
    }
    
    func fetchData() {
        let userEmail = Auth.auth().currentUser?.email
        
        Firestore.firestore().collection("Post").order(by: "date" , descending: true)
            .addSnapshotListener { snapshot, err in
                if err != nil {
                    print(err!.localizedDescription)
                } else {
                    
                    if snapshot?.isEmpty != true && snapshot != nil {
                        self.postArray.removeAll(keepingCapacity: false)
                        
                        for document in snapshot!.documents {
                            
                            if let email = document.get("email") as? String {
                                
                                if email == userEmail {
                                    if let coinName = document.get("coinname") as? String {
                                        
                                        if let coinquantity = document.get("coinquantity") as? Double {
                                            
                                            if let totalprice = document.get("totalprice") as? String {
                                                
                                                let post = PostModel(email: email, coinname: coinName, coinquantity: coinquantity, totalprice: totalprice)
                                                self.postArray.append(post)
                                            }
                                        }
                                    }
                                } else {
                                    // If current email and firestore email is not matching , do nothing! go next loop
                                }
                            }
                        }
                        self.collectionTableView.reloadData()
                    }
                }
            }
    }
}

extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = collectionTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CollectionTableViewCell
        cell.coinNameLabel.text = postArray[indexPath.row].coinname
        cell.quantityLabel.text = String(postArray[indexPath.row].coinquantity)
        cell.priceLabel.text = String(postArray[indexPath.row].totalprice)
        return cell
    }
}
