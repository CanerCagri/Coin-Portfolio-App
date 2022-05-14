//
//  ViewController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var createBtn: UIButton!
    @IBOutlet var logitnBtn: UIButton!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    

    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var createLabel: UILabel!


    @IBOutlet var emailLabel: UILabel!
    
    let viewControllerViewModel = MainViewControllerViewModel()
    let mainVcConstants = MainVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadButtonsOptions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 100).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60).isActive = true
        
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor , constant: 30).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
      
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor , constant: 5).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60).isActive = true
        
        logitnBtn.translatesAutoresizingMaskIntoConstraints = false
        logitnBtn.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor , constant: 30).isActive = true
        logitnBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        logitnBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        createLabel.translatesAutoresizingMaskIntoConstraints = false
        createLabel.topAnchor.constraint(equalTo: logitnBtn.bottomAnchor , constant: 10).isActive = true
        createLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        
        createBtn.translatesAutoresizingMaskIntoConstraints = false
        createBtn.topAnchor.constraint(equalTo: logitnBtn.bottomAnchor).isActive = true
        createBtn.leadingAnchor.constraint(equalTo: createLabel.trailingAnchor, constant: 5).isActive = true
        
        
        
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        if passwordTextField.text != "" && emailTextField.text != "" {
            viewControllerViewModel.login(email: emailTextField.text!, password: passwordTextField.text!) { bool in
                if bool == true {
                    self.performSegue(withIdentifier: self.mainVcConstants.tabBarIdentifier, sender: nil)
                } else {
                    let ac = UIAlertController(title: "Error!", message: "Wrong id or password", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "OK", style: .default))
                    self.present(ac, animated: true)
                }
            }
        }
    }
    
    @IBAction func newAccountTapped(_ sender: Any) {
        performSegue(withIdentifier: mainVcConstants.signInVcIdentifier, sender: self)
    }
    
    func loadButtonsOptions() {
        logitnBtn.setTitleColor(.black, for: .normal)
        logitnBtn.setTitleColor(.yellow, for: .highlighted)
        logitnBtn.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        logitnBtn.backgroundColor = .orange
        logitnBtn.layer.borderWidth = 4
        logitnBtn.layer.borderColor = UIColor.yellow.cgColor
        logitnBtn.layer.cornerRadius = 32
    }
}

