//
//  TabBarController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var logoutButton = UIButton()
    
    let tabBarControllerViewModel = TabBarControllerViewModel()
    
    let tabBarC = TabBarC()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        createButton()
    }
    
    func createButton() {
        
        logoutButton = UIButton()
        logoutButton.setImage(UIImage(named: tabBarC.logoutImageName), for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.setTitleColor(.yellow, for: .highlighted)
        logoutButton.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        logoutButton.backgroundColor = .orange
        logoutButton.layer.borderWidth = 4
        logoutButton.layer.borderColor = UIColor.yellow.cgColor
        logoutButton.addTarget(self, action: #selector(addBtnTapped), for: .touchUpInside)
        logoutButton.tag = 100
        self.view.addSubview(logoutButton)
    }
    
    @objc func addBtnTapped(_ sender: UIButton!) {
        tabBarControllerViewModel.signOut()
        performSegue(withIdentifier: tabBarC.segueIdentifier, sender: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        logoutButton.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 160, width: 64, height: 64)
        logoutButton.layer.cornerRadius = 32
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selectedIndex == 1 {
            logoutButton.isHidden = true
        } else if selectedIndex == 0 {
            logoutButton.isHidden = false
        } else if selectedIndex == 2 {
            logoutButton.isHidden = true
        }
    }
}
