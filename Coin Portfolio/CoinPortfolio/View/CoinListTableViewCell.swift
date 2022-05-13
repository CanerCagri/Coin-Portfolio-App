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
    let priceSeperator = AddDeleteVC()
    
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
        // Price settings
        let apiPrice = postModel[indexPath.row].lastPrice
        let result = apiPrice.components(separatedBy: priceSeperator.lastPriceSeperator)
        if result[0].last != "." {  // Price checking , if price end with . after result add 0
            coinPrice.text = "$ \(result[0])"
           
        } else {
            let last = "$ \(result[0])0"
            coinPrice.text = last
            
        }
    }
}
