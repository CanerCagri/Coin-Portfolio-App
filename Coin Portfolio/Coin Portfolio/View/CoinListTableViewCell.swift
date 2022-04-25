//
//  CoinListTableViewCell.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 17.04.2022.
//

import UIKit

class CoinListTableViewCell: UITableViewCell {
    
    @IBOutlet var coinPrice: UILabel!
    @IBOutlet var coinName: UILabel!
    
    var priceString = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with postModel: [CoinModel], indexPath: IndexPath) {
        
        var symbolStr = postModel[indexPath.row].symbol
        symbolStr.insert("/", at: symbolStr.index(symbolStr.endIndex, offsetBy: -4))
        
        coinName.text = symbolStr
        priceString = postModel[indexPath.row].price
        priceString = priceString.components(separatedBy: "00")[0]
        coinPrice.text = priceString
        
        
        
        
        
    }
    
}
