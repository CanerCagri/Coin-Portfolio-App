//
//  ViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var createBtn: UIButton!
    @IBOutlet var logitnBtn: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    
    let viewControllerViewModel = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadButtonsOptions()
    }

    @IBAction func loginTapped(_ sender: Any) {
        if passwordTextField.text != "" && emailTextField.text != "" {
            viewControllerViewModel.login(email: emailTextField.text!, password: passwordTextField.text!) { bool in
                if bool == true {
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                } else {
                    let ac = UIAlertController(title: "Error!", message: "Wrong id or password", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "oK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    @IBAction func newAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "ToSigninVC", sender: self)
    }
    
    func loadButtonsOptions() {
        
        logitnBtn.setTitleColor(.black, for: .normal)
        logitnBtn.setTitleColor(.yellow, for: .highlighted)
        logitnBtn.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        logitnBtn.backgroundColor = .orange
        logitnBtn.layer.borderWidth = 4
        logitnBtn.layer.borderColor = UIColor.yellow.cgColor
        logitnBtn.layer.cornerRadius = 32
        
        createBtn.setTitleColor(.black, for: .normal)
        createBtn.setTitleColor(.yellow, for: .highlighted)
        createBtn.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        createBtn.backgroundColor = .orange
        createBtn.layer.borderWidth = 4
        createBtn.layer.borderColor = UIColor.yellow.cgColor
        createBtn.layer.cornerRadius = 32
    }
}

