//
//  CollectionViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Firebase

class CollectionViewController: UIViewController {

    @IBOutlet var collectionTableView: UITableView!
    
    var postArray = [Post] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
