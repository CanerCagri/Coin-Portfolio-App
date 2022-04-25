//
//  SigninViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let signinViewModel = SignViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccTapped(_ sender: Any) {
        if passwordTextField.text != "" && emailTextField.text != ""  {
            signinViewModel.createAccount(email: emailTextField.text!, password: passwordTextField.text!) { bool in
                if bool == true {
                    self.performSegue(withIdentifier: "toVC", sender: self)
                } else {
                    self.showError()
                }
            }
        } else {
            showError()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Error!", message: "Check please email and password areas.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "oK", style: .default))
        present(ac, animated: true)
    }
    
}
