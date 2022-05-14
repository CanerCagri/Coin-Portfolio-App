//
//  PortfolioCollectionViewCell.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 12.05.2022.
//

import UIKit

class PortfolioCollectionViewCell: UICollectionViewCell {
    
    var coinNameLabel : UILabel = {
        var coinName = UILabel()
        coinName.text = "CoinName"
        coinName.font = UIFont.boldSystemFont(ofSize: 15)
        coinName.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        return coinName
    }()
    
    var coinQuantityLabel : UILabel = {
        var coinName = UILabel()
        coinName.text = "Quantity"
        coinName.textColor = .darkGray
        coinName.font = UIFont.systemFont(ofSize: 10)
        coinName.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        return coinName
    }()
    
    var coinQuantityText : UILabel = {
        var coinName = UILabel()
        coinName.text = "CoinQuantityText"
        coinName.font = UIFont.systemFont(ofSize: 12)
        coinName.textColor = .brown
        coinName.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        return coinName
    }()
    
    var createdPriceLabel : UILabel = {
        var coinName = UILabel()
        coinName.text = "Portfolio Price"
        coinName.font = UIFont.systemFont(ofSize: 10)
        coinName.textColor = .darkGray
        coinName.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        return coinName
    }()
    
    var createdPriceText : UILabel = {
        var coinName = UILabel()
        coinName.text = "CreatedPriceText"
        coinName.font = UIFont.boldSystemFont(ofSize: 12)
        coinName.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        return coinName
    }()
    
    var currentPriceLabel : UILabel = {
        var coinName = UILabel()
        coinName.text = "Current Price"
        coinName.font = UIFont.systemFont(ofSize: 10)
        coinName.textColor = .darkGray
        coinName.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        return coinName
    }()
    
    var currentPriceText : UILabel = {
        var coinName = UILabel()
        coinName.text = "ERROR"
        coinName.font = UIFont.boldSystemFont(ofSize: 12)
        coinName.textColor = .red
        coinName.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        coinName.translatesAutoresizingMaskIntoConstraints = false
        return coinName
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 2
        contentView.layer.cornerRadius = 5
        
        contentView.addSubview(coinNameLabel)
        contentView.addSubview(coinQuantityLabel)
        contentView.addSubview(coinQuantityText)
        contentView.addSubview(createdPriceLabel)
        contentView.addSubview(createdPriceText)
        contentView.addSubview(currentPriceLabel)
        contentView.addSubview(currentPriceText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let low = coinNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        low.priority = .defaultLow
        low.isActive = true
        coinNameLabel.bottomAnchor.constraint(equalTo: coinQuantityLabel.topAnchor, constant: -30).isActive = true
        coinNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        coinQuantityLabel.bottomAnchor.constraint(equalTo: coinQuantityText.topAnchor, constant: -5).isActive = true
        coinQuantityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        coinQuantityText.bottomAnchor.constraint(equalTo: createdPriceLabel.topAnchor, constant: -12).isActive = true
        coinQuantityText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        createdPriceLabel.bottomAnchor.constraint(equalTo: createdPriceText.topAnchor, constant: -5).isActive = true
        createdPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        createdPriceText.bottomAnchor.constraint(equalTo: currentPriceLabel.topAnchor, constant: -12).isActive = true
        createdPriceText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        currentPriceLabel.bottomAnchor.constraint(equalTo: currentPriceText.topAnchor, constant: -5).isActive = true
        currentPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        currentPriceText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15).isActive = true

        currentPriceText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
