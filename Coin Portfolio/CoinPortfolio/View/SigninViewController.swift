//
//  SigninViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

class SigninViewController: UIViewController {
    
    
   
    @IBOutlet var signupLabel: UILabel!
    
 
    @IBOutlet var popupView: UIView!
   
    @IBOutlet var emailLabel: UILabel!
    
    @IBOutlet var passwordLabel: UILabel!
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
  

    @IBOutlet var createBtn: UIButton!
    @IBOutlet var cancelButton: UIButton!

    let signinViewModel = SignViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        signupLabel.translatesAutoresizingMaskIntoConstraints = false
        signupLabel.topAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        signupLabel.centerXAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.centerXAnchor).isActive = true
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 30).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
       
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -30).isActive = true
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -30).isActive = true
        
        createBtn.translatesAutoresizingMaskIntoConstraints = false
        createBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 35).isActive = true
        createBtn.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        createBtn.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -30).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.topAnchor.constraint(equalTo: createBtn.bottomAnchor, constant: 45).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: popupView.safeAreaLayoutGuide.leadingAnchor, constant: 60).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: popupView.trailingAnchor, constant: -60).isActive = true
    }
    
    func showError() {
        let ac = UIAlertController(title: "Error!", message: "Check please email and password areas.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
