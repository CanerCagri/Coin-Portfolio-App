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
        coinName.text = "CurrentPriceText"
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
        
        coinNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        coinNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -60).isActive = true
        
        coinQuantityLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 15).isActive = true
        coinQuantityLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        coinQuantityText.topAnchor.constraint(equalTo: coinQuantityLabel.bottomAnchor, constant: 5).isActive = true
        coinQuantityText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        createdPriceLabel.topAnchor.constraint(equalTo: coinQuantityText.bottomAnchor, constant: 12).isActive = true
        createdPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        createdPriceText.topAnchor.constraint(equalTo: createdPriceLabel.bottomAnchor, constant: 5).isActive = true
        createdPriceText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        currentPriceLabel.topAnchor.constraint(equalTo: createdPriceText.bottomAnchor, constant: 12).isActive = true
        currentPriceLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        currentPriceText.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 5).isActive = true
        currentPriceText.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
}
