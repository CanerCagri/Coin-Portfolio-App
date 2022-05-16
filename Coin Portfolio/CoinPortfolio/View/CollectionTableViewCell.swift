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
        if postModel.count != 0 {
            let apiPrice = String(postModel[indexPath.row].totalprice)
            
            priceLabel.text = apiPrice
            coinNameLabel.text = postModel[indexPath.row].coinname
            quantityLabel.text = String(postModel[indexPath.row].coinquantity)
        } else {
            
        }
        
    }
}
