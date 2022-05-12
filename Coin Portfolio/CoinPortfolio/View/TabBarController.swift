//
//  TabBarController.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 14.04.2022.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var logoutButton = UIButton()
    var welcomeLabel = UILabel()
    var currentUserLabel = UILabel()
    var priceLabel = UILabel()
    var totalPriceLabel = UILabel()
    var calculateButton = UIButton()
    var portfolioValueLabel = UILabel()
    var portfolioValue = UILabel()
    var changeLabel = UILabel()
    var changeText = UILabel()
    var currentPriceLabel = UILabel()
    var currentTotalPriceLabel = UILabel()
    
    let tabBarControllerViewModel = TabBarControllerViewModel()
    let tabBarC = TabBarC()
    
    var coinListArray = [CoinModel] ()
    var postListArray = [PostModel] ()
    var lastValue = [Double] ()
    var coinName = [String] ()
    var coinQuantity = [Double] ()
    var calculatedPrice = 0.0
    var totalPriceHolder = [Double] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        createInterface()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        coinListArray.removeAll(keepingCapacity: false)
        postListArray.removeAll(keepingCapacity: false)
        lastValue.removeAll(keepingCapacity: false)
        coinName.removeAll(keepingCapacity: false)
        coinQuantity.removeAll(keepingCapacity: false)
        totalPriceHolder.removeAll(keepingCapacity: false)
        calculateButton.isHidden = true
        portfolioValueLabel.isHidden = true
        portfolioValue.isHidden = true
        changeLabel.isHidden = true
        changeText.isHidden = true
        currentPriceLabel.isHidden = true
        currentTotalPriceLabel.isHidden = true
        
        tabBarControllerViewModel.output = self
        tabBarControllerViewModel.fetchPostItems()
    }
    
    func createInterface() {
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        welcomeLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(welcomeLabel)
        
        let currentUser = Auth.auth().currentUser!.email
        let user = currentUser!.components(separatedBy: "@")
        currentUserLabel = UILabel()
        currentUserLabel.text = "\(user[0])!"
        currentUserLabel.font = UIFont.boldSystemFont(ofSize: 30)
        currentUserLabel.textColor = UIColor.red
        currentUserLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(currentUserLabel)
        
        priceLabel = UILabel()
        priceLabel.text = "Portfolio Created Price :"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(priceLabel)
        
        totalPriceLabel = UILabel()
        totalPriceLabel.text = "$ 0.0"
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalPriceLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(totalPriceLabel)
        
        calculateButton = UIButton()
        calculateButton.setTitle("CALCULATE", for: .normal)
        calculateButton.setTitleColor(.black, for: .normal)
        calculateButton.setTitleColor(.yellow, for: .highlighted)
        calculateButton.frame = CGRect(x: 0, y: 0, width: 150, height: 100)
        calculateButton.backgroundColor = .orange
        calculateButton.layer.borderWidth = 4
        calculateButton.addTarget(self, action: #selector(calculateBtnTapped), for: .touchUpInside)
        calculateButton.isHidden = true
        self.view.addSubview(calculateButton)
        
        portfolioValueLabel = UILabel()
        portfolioValueLabel.text = "My Portfolio"
        portfolioValueLabel.textColor = .darkGray
        portfolioValueLabel.font = UIFont.systemFont(ofSize: 15)
        portfolioValueLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
        portfolioValueLabel.isHidden = true
        self.view.addSubview(portfolioValueLabel)
        
        portfolioValue = UILabel()
        portfolioValue.text = ""
        portfolioValue.textAlignment = .center
        portfolioValue.font = UIFont.boldSystemFont(ofSize: 20)
        portfolioValue.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        portfolioValue.isHidden = true
        self.view.addSubview(portfolioValue)
        
        changeLabel = UILabel()
        changeLabel.text = "Change"
        changeLabel.textAlignment = .center
        changeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        changeLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        changeLabel.isHidden = true
        self.view.addSubview(changeLabel)
        
        changeText = UILabel()
        changeText.text = ""
        changeText.textAlignment = .center
        changeText.font = UIFont.boldSystemFont(ofSize: 20)
        changeText.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        changeText.isHidden = true
        self.view.addSubview(changeText)
        
        currentPriceLabel = UILabel()
        currentPriceLabel.text = "Currently Total Price"
        currentPriceLabel.textColor = .darkGray
        currentPriceLabel.font = UIFont.systemFont(ofSize: 13)
        currentPriceLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
        currentPriceLabel.isHidden = true
        self.view.addSubview(currentPriceLabel)
        
        currentTotalPriceLabel = UILabel()
        currentTotalPriceLabel.text = ""
        currentTotalPriceLabel.textAlignment = .center
        currentTotalPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        currentTotalPriceLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        currentTotalPriceLabel.isHidden = true
        self.view.addSubview(currentTotalPriceLabel)
        
        logoutButton = UIButton()
        logoutButton.setImage(UIImage(named: tabBarC.logoutImageName), for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.setTitleColor(.yellow, for: .highlighted)
        logoutButton.frame = CGRect(x: 100, y: 0, width: 44, height: 44)
        logoutButton.backgroundColor = .orange
        logoutButton.layer.borderWidth = 4
        logoutButton.layer.borderColor = UIColor.yellow.cgColor
        logoutButton.addTarget(self, action: #selector(logoutBtnTapped), for: .touchUpInside)
        logoutButton.tag = 100
        self.view.addSubview(logoutButton)
    }
    
    
    @objc func calculateBtnTapped(_ sender: UIButton!) {
        if postListArray.count != 0 {
            for index in 0..<coinName.count {
                tabBarControllerViewModel.fetchSelectedItems(selectedItem: coinName[index])
            }
            coinName.removeAll(keepingCapacity: false)
            coinQuantity.removeAll(keepingCapacity: false)
            lastValue.removeAll(keepingCapacity: false)
            portfolioValueLabel.isHidden = false
            portfolioValue.isHidden = false
            changeLabel.isHidden = false
            changeText.isHidden = false
            currentPriceLabel.isHidden = false
            currentTotalPriceLabel.isHidden = false
        }
    }
    
    @objc func logoutBtnTapped(_ sender: UIButton!) {
        tabBarControllerViewModel.signOut()
        performSegue(withIdentifier: tabBarC.segueIdentifier, sender: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        
        currentUserLabel.translatesAutoresizingMaskIntoConstraints = false
        currentUserLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        currentUserLabel.leadingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor, constant: 35).isActive = true
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 125).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40 ).isActive = true
        
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.topAnchor.constraint(equalTo: currentUserLabel.bottomAnchor, constant: 125).isActive = true
        totalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20).isActive = true
        
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.topAnchor.constraint(equalTo: priceLabel.topAnchor, constant: 50).isActive = true
        calculateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 90).isActive = true
        calculateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -90).isActive = true
        
        portfolioValueLabel.translatesAutoresizingMaskIntoConstraints = false
        portfolioValueLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 150).isActive = true
        portfolioValueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 30).isActive = true
        
        portfolioValue.translatesAutoresizingMaskIntoConstraints = false
        portfolioValue.topAnchor.constraint(equalTo: portfolioValueLabel.bottomAnchor, constant: 10).isActive = true
        portfolioValue.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35).isActive = true
        
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 150).isActive = true
        changeLabel.leadingAnchor.constraint(equalTo: portfolioValueLabel.trailingAnchor, constant: 50).isActive = true
        
        changeText.translatesAutoresizingMaskIntoConstraints = false
        changeText.topAnchor.constraint(equalTo: changeLabel.bottomAnchor, constant: 10).isActive = true
        changeText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 160).isActive = true
        
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPriceLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 150).isActive = true
        currentPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -20).isActive = true
        
        currentTotalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTotalPriceLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 10).isActive = true
        currentTotalPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        
        logoutButton.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 160, width: 64, height: 64)
        logoutButton.layer.cornerRadius = 32
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if selectedIndex == 0 {
            totalPriceLabel.text = String(CollectionViewController.shared.calculatedBalance)
            
            tabBarControllerViewModel.output = self
            tabBarControllerViewModel.fetchPostItems()
            
            logoutButton.isHidden = false
            welcomeLabel.isHidden = false
            currentUserLabel.isHidden = false
            priceLabel.isHidden = false
            totalPriceLabel.isHidden = false
            
        } else if selectedIndex == 1 {
            logoutButton.isHidden = true
            welcomeLabel.isHidden = true
            currentUserLabel.isHidden = true
            priceLabel.isHidden = true
            totalPriceLabel.isHidden = true
            calculateButton.isHidden = true
            portfolioValueLabel.isHidden = true
            portfolioValue.isHidden = true
            changeLabel.isHidden = true
            changeText.isHidden = true
            currentPriceLabel.isHidden = true
            currentTotalPriceLabel.isHidden = true
            
        }  else if selectedIndex == 2 {
            logoutButton.isHidden = true
            welcomeLabel.isHidden = true
            currentUserLabel.isHidden = true
            priceLabel.isHidden = true
            totalPriceLabel.isHidden = true
            calculateButton.isHidden = true
            portfolioValueLabel.isHidden = true
            portfolioValue.isHidden = true
            changeLabel.isHidden = true
            changeText.isHidden = true
            currentPriceLabel.isHidden = true
            currentTotalPriceLabel.isHidden = true
        }
    }
    
    
    func fetchTotalPrice() {
        
        for index in 0..<postListArray.count {
            coinName.append(postListArray[index].coinname)
            coinQuantity.append(postListArray[index].coinquantity)
            totalPriceHolder.append( Double(postListArray[index].totalprice)!)
            calculatedPrice += totalPriceHolder[index]
        }
        let result = String(format: "%.2f", ceil(calculatedPrice * 100) / 100)
        totalPriceLabel.text = "$ \(result)"
        calculateButton.isHidden = false
    }
}

extension TabBarController: TabBarViewModelOutput {
    func postUpdate(valuePostList: [PostModel]) {
        coinName.removeAll(keepingCapacity: false)
        coinQuantity.removeAll(keepingCapacity: false)
        postListArray.removeAll(keepingCapacity: false)
        postListArray = valuePostList
        fetchTotalPrice()
    }
    
    func updateView(valueCoinList: [CoinModel]) {
        coinListArray += valueCoinList
        
        if coinListArray.count == postListArray.count {
            for index in 0..<postListArray.count {
                let temp = Double(coinListArray[index].lastPrice)! * Double(postListArray[index].coinquantity)
                lastValue.append(temp)
                
            }
            let totalSum = lastValue.reduce(0, +)
            let result = String(format: "%.2f", ceil(totalSum * 100) / 100)
            currentTotalPriceLabel.text = "$ \(result)"
            portfolioValue.text = totalPriceLabel.text
            let value1Input = String(format: "%.2f", ceil(calculatedPrice * 100) / 100)
            guard let value1 = Double(value1Input) else {return}
            guard let value2 = Double(result) else { return}
            if value1 != 0 {
                if value1 < value2 {
                    let firstOutput = ((value1 - value2) / value2) * 100
                    let secondOutput = String(format: "%.2f", ceil(firstOutput * 100) / 100)
                    let thirdOutput = secondOutput.components(separatedBy: "-")[1]
                    changeText.text = thirdOutput
                    changeText.textColor = .blue
                } else if value1 > value2{
                    let firstOutput = ((value2 - value1) / value1) * 100
                    changeText.text = String(format: "%.2f", ceil(firstOutput * 100) / 100)
                    changeText.textColor = .red
                }
            }
        }
    }
}
