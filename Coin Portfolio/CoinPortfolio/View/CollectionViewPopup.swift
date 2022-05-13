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
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var updateBtn: UIButton!
    
    var coinName : String?
    var coinPrice : String?
    var coinQuantity : String?
    var coinID : String?
    
    let collectionPopupViewModel = CollectionPopupViewModel()
    weak var delegate: CollectionViewPopupProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBtn.isEnabled = false
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
