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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
