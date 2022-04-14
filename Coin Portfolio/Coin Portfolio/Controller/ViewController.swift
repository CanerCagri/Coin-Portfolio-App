//
//  ViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginTapped(_ sender: Any) {
        if passwordTextField.text != "" && emailTextField.text != "" {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self]  result, error in
                if error != nil {
                    let vc = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: .alert)
                    vc.addAction(UIAlertAction(title: "OK", style: .default))
                    self?.present(vc, animated: true)
                } else {
                    self?.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
            }
        }
    }
    
    @IBAction func newAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: "ToSigninVC", sender: self)
    }
}

