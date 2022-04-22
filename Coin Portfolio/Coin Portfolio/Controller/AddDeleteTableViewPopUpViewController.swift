//
//  AddDeleteTableViewPopUpViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 19.04.2022.
//

import UIKit
import Firebase

class AddDeleteTableViewPopUpViewController: UIViewController {
    
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var coinNameLabel: UILabel!
    @IBOutlet var coinPriceLabel: UILabel!
    
    @IBOutlet var quantityTextField: UITextField!
    @IBOutlet var selectedCoin: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    var coinName : String?
    var coinPrice : String?
    var selectedCoinPrice : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBtn.isEnabled = false
        totalPrice.text = ""
        quantityTextField.delegate = self
        
        if coinName != nil && coinPrice != nil {
            coinNameLabel.text = coinName!
            coinPriceLabel.text = String(coinPrice!)
            
            let selectedCoinName = coinNameLabel.text?.components(separatedBy: "/USDT")[0]
            selectedCoin.text = selectedCoinName
        }
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
        let fireStorePost = ["email" : Auth.auth().currentUser!.email! , "coinname" : selectedCoin.text! , "coinquantity" : selectedCoinPrice! , "totalprice" : totalPrice.text! , "date" : FieldValue.serverTimestamp()] as [String:Any]
        
        fireStoreDatabase.collection("Post").addDocument(data: fireStorePost) { err in
            if err != nil {
                let ac = UIAlertController(title: "Error", message: err?.localizedDescription ?? "Error! try again", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(ac, animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func cancelBtnTapped(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension AddDeleteTableViewPopUpViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == quantityTextField {
            
            if quantityTextField.text == "" {
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
                totalPrice.text = String(total)
                
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
