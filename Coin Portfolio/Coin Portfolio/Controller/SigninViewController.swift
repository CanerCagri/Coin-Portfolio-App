//
//  SigninViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Firebase

class SigninViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccTapped(_ sender: Any) {
        
        if passwordTextField.text != "" && emailTextField.text != ""  {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] result, error in
                if error != nil {
                    let vc = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                    vc.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(vc, animated: true)
                } else {
                    self?.performSegue(withIdentifier: "toVC", sender: self)
                }
            }
        }
    }
}
