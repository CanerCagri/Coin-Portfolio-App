//
//  CollectionViewPopup.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 13.05.2022.
//

import UIKit

protocol CollectionViewPopupProtocol: AnyObject {
    func settingsUpdated()
}

class CollectionViewPopup: UIViewController {
    
    @IBOutlet var coinNameLabel: UILabel!
    @IBOutlet var quantityLabel: UILabel!
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var updateBtn: UIButton!
    @IBOutlet var popupView: UIView!
    @IBOutlet var cancelBtn: UIButton!
    
    var coinName : String?
    var coinPrice : String?
    var coinQuantity : String?
    var coinID : String?
    
    let collectionPopupViewModel = CollectionPopupViewModel()
    weak var delegate: CollectionViewPopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quantityTextField.delegate = self
        priceTextField.delegate = self
        
        coinNameLabel.text = coinName
        quantityTextField.text = coinQuantity
        priceTextField.text = coinPrice
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coinNameLabel.text = coinName
        quantityTextField.text = coinQuantity
        priceTextField.text = coinPrice
        priceLabel.textAlignment = .center
    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        let quantity = Double(quantityTextField.text!)!
        collectionPopupViewModel.postUpdateDocument(selectedCoinId: coinID!, selectedCoin: coinName!, selectedCoinQuantity: quantity, totalPrice: priceTextField.text!)
        delegate?.settingsUpdated()
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
        
      
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 60).isActive = true
        quantityLabel.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 60).isActive = true
        
        quantityTextField.translatesAutoresizingMaskIntoConstraints = false
        quantityTextField.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 10).isActive = true
        quantityTextField.leadingAnchor.constraint(equalTo: quantityLabel.leadingAnchor).isActive = true
        quantityTextField.trailingAnchor.constraint(equalTo: quantityLabel.trailingAnchor).isActive = true
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: coinNameLabel.bottomAnchor, constant: 60).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: quantityLabel.safeAreaLayoutGuide.trailingAnchor, constant: 50).isActive = true
        
        priceTextField.translatesAutoresizingMaskIntoConstraints = false
        priceTextField.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10).isActive = true
        priceTextField.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor).isActive = true
        priceTextField.trailingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.trailingAnchor, constant: -60).isActive = true
        
        
        updateBtn.translatesAutoresizingMaskIntoConstraints = false
        updateBtn.topAnchor.constraint(equalTo: priceTextField.bottomAnchor, constant: 40).isActive = true
        updateBtn.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
        updateBtn.trailingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.trailingAnchor, constant: -100).isActive = true
        
        cancelBtn.translatesAutoresizingMaskIntoConstraints = false
        cancelBtn.topAnchor.constraint(equalTo: updateBtn.bottomAnchor, constant: 50).isActive = true
        cancelBtn.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 110).isActive = true
        cancelBtn.trailingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.trailingAnchor, constant: -120).isActive = true
    }
}

extension CollectionViewPopup: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == quantityTextField {
            if quantityTextField.text == "" || quantityTextField.text == "0" || quantityTextField.text == "0.0" || quantityTextField.text?.last == "." {
                updateBtn.isEnabled = false
            } else {
                updateBtn.isEnabled = true
            }
        } else if textField == priceTextField {
            if priceTextField.text == "" || priceTextField.text == "0" || priceTextField.text == "0.0" || priceTextField.text?.last == "." {
                updateBtn.isEnabled = false
            } else {
                updateBtn.isEnabled = true
            }
        }
    }
}
