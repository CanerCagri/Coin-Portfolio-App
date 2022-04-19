//
//  AddDeleteTableViewPopUpViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 19.04.2022.
//

import UIKit
import Firebase

class AddDeleteTableViewPopUpViewController: UIViewController {

    @IBOutlet var coinNameLabel: UILabel!
    @IBOutlet var coinPriceLabel: UILabel!
    
    var coinName : String?
    var coinPrice : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if coinName != nil && coinPrice != nil {
            coinNameLabel.text = coinName!
            coinPriceLabel.text = String(coinPrice!)
        }
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}
