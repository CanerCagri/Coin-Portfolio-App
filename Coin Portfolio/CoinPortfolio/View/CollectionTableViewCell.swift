//
//  CollectionTableViewCell.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 20.04.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {

    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var coinNameLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    
    let priceSeperator = AddDeleteVC()
    
    func configure(with postModel: [PostModel], indexPath: IndexPath) {
        let apiPrice = postModel[indexPath.row].totalprice
        let result = apiPrice.components(separatedBy: priceSeperator.lastPriceSeperator)
        if result[0].last != "." {  // Price checking , if price end with . after result add 0
            priceLabel.text = "$ \(result[0])"
           
        } else {
            let last = "$ \(result[0])0"
            priceLabel.text = last
        }
        coinNameLabel.text = postModel[indexPath.row].coinname
        quantityLabel.text = String(postModel[indexPath.row].coinquantity)
    }
}
