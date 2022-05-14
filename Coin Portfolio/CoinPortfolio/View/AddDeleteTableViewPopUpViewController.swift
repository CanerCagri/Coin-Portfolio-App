//
//  AddDeleteTableViewPopUpViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 19.04.2022.
//

import UIKit

class AddDeleteTableViewPopUpViewController: UIViewController {
    
    @IBOutlet var cancelBtn: UIButton!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var coinNameLabel: UILabel!
    @IBOutlet var coinPriceLabel: UILabel!
    
    @IBOutlet var popupView: UIView!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var selectedCoin: UILabel! // hidden atm
    @IBOutlet var totalPrice: UILabel!
    
    var coinName : String?
    var coinPrice : String?
    var selectedCoinPrice : Double?
    
    let addPopupViewModel = AddPopupViewModel()
    let addDeletePopup = AddDeletePopupVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedCoin.isHidden = true
        addBtn.isEnabled = false
        totalPrice.text = "0.0"
        quantityTextField.delegate = self
        
        if coinName != nil && coinPrice != nil {
            coinNameLabel.text = coinName!
            coinPriceLabel.text = "$ String(coinPrice!)"
            let selectedCoinName = coinNameLabel.text?.components(separatedBy: addDeletePopup.selectedCoinNameSeperator)[0]
            selectedCoin.text = selectedCoinName
        }
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        addPopupViewModel.postAddDocument(selectedCoin: selectedCoin.text!, selectedCoinQuantity: selectedCoinPrice!, totalPrice: totalPrice.text!)
        dismiss(animated: true)
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        coinNameLabel.translatesAutoresizingMaskIntoConstraints = false
        coinNameLabel.topAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        coinNameLabel.centerXAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        coinPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        coinPriceLabel.topAnchor.constraint(equalTo: coinNameLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
        coinPriceLabel.centerXAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.topAnchor.constraint(equalTo: coinPriceLabel.bottomAnchor, constant: 50).isActive = true
        quantityLabel.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 60).isActive = true
        
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        quantityTextField.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 10).isActive = true
        quantityTextField.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor).isActive = true
        quantityTextField.trailingAnchor.constraint(equalTo: quantityLabel.trailingAnchor).isActive = true
        
        totalPrice.translatesAutoresizingMaskIntoConstraints = false
        totalPrice.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 10).isActive = true
        totalPrice.leadingAnchor.constraint(equalTo: quantityTextField.safeAreaLayoutGuide.trailingAnchor, constant: 50).isActive = true
        
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        addBtn.topAnchor.constraint(equalTo: totalPrice.bottomAnchor, constant: 40).isActive = true
        addBtn.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
        addBtn.trailingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.topAnchor.constraint(equalTo: addBtn.bottomAnchor, constant: 50).isActive = true
        cancelBtn.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 110).isActive = true
        cancelBtn.trailingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.trailingAnchor, constant: -120).isActive = true
        
        
        
        
    }
}

extension AddDeleteTableViewPopUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == quantityTextField {
            
            if quantityTextField.text == "" || quantityTextField.text == "0" || quantityTextField.text == "0.0" || quantityTextField.text?.last == "." {
                totalPrice.text = "..."
                addBtn.isEnabled = false
            } else {
                addBtn.isEnabled = true
            }
            selectedCoinPrice = Double(quantityTextField.text ?? "0")
            guard let selectedCoinPrice = selectedCoinPrice else {
                return
            }
            if selectedCoinPrice > 1.0 {
                let total = selectedCoinPrice * Double(coinPrice!)!
                let totalValue = String(total)
                let totalResult = totalValue.components(separatedBy: "9999")
                totalPrice.text = totalResult[0]
            } else if selectedCoinPrice < 1.0 {
                let total = selectedCoinPrice / Double(coinPrice!)!
                totalPrice.text = String(total)
            } else if selectedCoinPrice == 1.0  {
                totalPrice.text = coinPrice!
            } else if selectedCoinPrice == 0 {
                totalPrice.text = "0"
            }
        }
    }
}
