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
    
    func configure(with postModel: [PostModel], indexPath: IndexPath) {
        priceLabel.text = postModel[indexPath.row].totalprice
        coinNameLabel.text = postModel[indexPath.row].coinname
        quantityLabel.text = String(postModel[indexPath.row].coinquantity)
    }
}
