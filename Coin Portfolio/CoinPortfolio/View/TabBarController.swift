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
    var portfolioValueLabel = UILabel()
    var portfolioValue = UILabel()
    var changeLabel = UILabel()
    var changeText = UILabel()
    var currentPriceLabel = UILabel()
    var currentTotalPriceLabel = UILabel()
    var portfolioCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        return collection
       
    }()
    
    let tabBarControllerViewModel = TabBarControllerViewModel()
    let tabBarC = TabBarC()
    var coinListArray = [Double] ()
    var postListArray = [PostModel] ()
    var saveByName = [CoinModel] ()
    var lastValue = [Double] ()
    var calculatedPrice = 0.0
    var totalPriceHolder = [Double] ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.delegate = self
        portfolioCollectionView.dataSource = self
        portfolioCollectionView.delegate = self
        
        createInterface()
        tabBarControllerViewModel.output = self
        tabBarControllerViewModel.fetchPostItems()
    }
    
    @objc func logoutBtnTapped(_ sender: UIButton!) {
        tabBarControllerViewModel.signOut()
        performSegue(withIdentifier: tabBarC.segueIdentifier, sender: nil)
    }
    
    func loadChange() {
        if postListArray.count != 0 {
            for index in 0..<postListArray.count {
                tabBarControllerViewModel.fetchSelectedItems(index: index, selectedItem: postListArray[index].coinname , selectedItemQuantity: postListArray[index].coinquantity)
                tabBarControllerViewModel.fetchSelectedByName(selectedItem: postListArray[index].coinname)
            }
        }
    }
    
    func fetchTotalPrice() {
        for index in 0..<postListArray.count {
            totalPriceHolder.append( Double(postListArray[index].totalprice)!)
            calculatedPrice += totalPriceHolder[index]
        }
        let result = String(format: "%.2f", ceil(calculatedPrice * 100) / 100)
        totalPriceLabel.text = "$ \(result)"
        loadChange()
    }
    
    func clearAll() {
        coinListArray.removeAll(keepingCapacity: false)
        postListArray.removeAll(keepingCapacity: false)
        lastValue.removeAll(keepingCapacity: false)
        totalPriceHolder.removeAll(keepingCapacity: false)
        portfolioValueLabel.isHidden = true
        portfolioValue.isHidden = true
        changeLabel.isHidden = true
        changeText.isHidden = true
        currentPriceLabel.isHidden = true
        currentTotalPriceLabel.isHidden = true
        portfolioCollectionView.isHidden = true
        totalPriceLabel.text = "0.0"
        calculatedPrice = 0
        portfolioValue.text = ""
        currentTotalPriceLabel.text = ""
        changeText.text = ""
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if selectedIndex == 0 {
            clearAll()
            
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
            portfolioValueLabel.isHidden = true
            portfolioValue.isHidden = true
            changeLabel.isHidden = true
            changeText.isHidden = true
            currentPriceLabel.isHidden = true
            currentTotalPriceLabel.isHidden = true
            portfolioCollectionView.isHidden = true
        }  else if selectedIndex == 2 {
            logoutButton.isHidden = true
            welcomeLabel.isHidden = true
            currentUserLabel.isHidden = true
            priceLabel.isHidden = true
            totalPriceLabel.isHidden = true
            portfolioValueLabel.isHidden = true
            portfolioValue.isHidden = true
            changeLabel.isHidden = true
            changeText.isHidden = true
            currentPriceLabel.isHidden = true
            currentTotalPriceLabel.isHidden = true
            portfolioCollectionView.isHidden = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        
        currentUserLabel.translatesAutoresizingMaskIntoConstraints = false
        currentUserLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        currentUserLabel.leadingAnchor.constraint(equalTo: welcomeLabel.trailingAnchor, constant: 30).isActive = true
        
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 25).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40 ).isActive = true
        
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        totalPriceLabel.topAnchor.constraint(equalTo: currentUserLabel.bottomAnchor, constant: 25).isActive = true
        totalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 20).isActive = true
        
        portfolioValueLabel.translatesAutoresizingMaskIntoConstraints = false
        portfolioValueLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50).isActive = true
        portfolioValueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor , constant: 30).isActive = true
        
        portfolioValue.translatesAutoresizingMaskIntoConstraints = false
        portfolioValue.topAnchor.constraint(equalTo: portfolioValueLabel.bottomAnchor, constant: 10).isActive = true
        portfolioValue.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 25).isActive = true
        
        changeLabel.translatesAutoresizingMaskIntoConstraints = false
        changeLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50).isActive = true
        changeLabel.leadingAnchor.constraint(equalTo: portfolioValueLabel.trailingAnchor, constant:  35).isActive = true
        
        changeText.translatesAutoresizingMaskIntoConstraints = false
        changeText.topAnchor.constraint(equalTo: changeLabel.bottomAnchor, constant: 10).isActive = true
        changeText.leadingAnchor.constraint(equalTo: changeLabel.leadingAnchor).isActive = true
        
        currentPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentPriceLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 50).isActive = true
        currentPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor , constant: -20).isActive = true
        
        currentTotalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTotalPriceLabel.topAnchor.constraint(equalTo: currentPriceLabel.bottomAnchor, constant: 10).isActive = true
        currentTotalPriceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        portfolioCollectionView.translatesAutoresizingMaskIntoConstraints = false
        portfolioCollectionView.topAnchor.constraint(equalTo: portfolioValue.bottomAnchor, constant: 25).isActive = true
        portfolioCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        portfolioCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        portfolioCollectionView.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -10).isActive = true
        
        logoutButton.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 160, width: 64, height: 64)
        logoutButton.layer.cornerRadius = 32
    }
    
    func createInterface() {
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome"
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 30)
        welcomeLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(welcomeLabel)
        
        let currentUser = Auth.auth().currentUser!.email
        let user = currentUser!.components(separatedBy: "@")
        let userCapatitalized = user[0].capitalized
        currentUserLabel = UILabel()
        currentUserLabel.text = "\(userCapatitalized)!"
        currentUserLabel.font = UIFont.boldSystemFont(ofSize: 30)
        currentUserLabel.textColor = UIColor.red
        currentUserLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(currentUserLabel)
        
        priceLabel = UILabel()
        priceLabel.text = "My Portfolio Price:"
        priceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        priceLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(priceLabel)
        
        totalPriceLabel = UILabel()
        totalPriceLabel.text = "$ 0.0"
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        totalPriceLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        self.view.addSubview(totalPriceLabel)
        
        portfolioValueLabel = UILabel()
        portfolioValueLabel.text = "My Portfolio"
        portfolioValueLabel.textColor = .darkGray
        portfolioValueLabel.textAlignment = .left
        portfolioValueLabel.font = UIFont.systemFont(ofSize: 15)
        portfolioValueLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
        portfolioValueLabel.isHidden = true
        self.view.addSubview(portfolioValueLabel)
        
        portfolioValue = UILabel()
        portfolioValue.text = ""
        portfolioValue.textAlignment = .left
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
        changeText.font = UIFont.boldSystemFont(ofSize: 20)
        changeText.textAlignment = .center
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
        currentTotalPriceLabel.textAlignment = .right
        currentTotalPriceLabel.font = UIFont.boldSystemFont(ofSize: 20)
        currentTotalPriceLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        currentTotalPriceLabel.isHidden = true
        self.view.addSubview(currentTotalPriceLabel)
        
        portfolioCollectionView.register(PortfolioCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(portfolioCollectionView)
        
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
}

extension TabBarController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.height/7)-4, height: (view.frame.size.height/3.5))
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postListArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = portfolioCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PortfolioCollectionViewCell
        let currentItem = postListArray[indexPath.row]
        cell?.coinNameLabel.text = currentItem.coinname
        cell?.coinQuantityText.text = String(currentItem.coinquantity)
        let createdPrice = "$ \(currentItem.totalprice)"
        let createdResult = createdPrice.components(separatedBy: "9999")
        cell?.createdPriceText.text = createdResult[0]
        
        //Bug fixed when current price texting. Below codes fixing that bug
            for i in indexPath.row..<postListArray.count  {
                let postName = postListArray[i].coinname
                for j in 0..<postListArray.count {
                    if j >= saveByName.count {
                        cell?.currentPriceText.text = "ERROR"
                        return cell!
                    }
                    let priceName = saveByName[j].symbol
                    let result = priceName.components(separatedBy: "USDT")
                    if postName != result[0] {
                        //do nothing!
                    } else {
                        let price = String(saveByName[j].lastPrice)
                        let priceresult = price.components(separatedBy: "0000")
                        if priceresult[0].last != "." {
                            cell?.currentPriceText.text = "$ \(priceresult[0])"
                            return cell!
                            
                        } else {
                            let last = "$ \(priceresult[0])0"
                            cell?.currentPriceText.text = last
                            return cell!
                        }
                    }
                }
            }
        return cell!
    }
}

extension TabBarController: TabBarViewModelOutput {
    
    func currentlyCoinPrice(valuePostList: [CoinModel]) {
        saveByName += valuePostList
        if saveByName.count == postListArray.count {
        }
    }
    
    func postUpdate(valuePostList: [PostModel]) {
        postListArray.removeAll(keepingCapacity: false)
        postListArray = valuePostList
        fetchTotalPrice()
    }
    
    func currentlyTotalPrice(valueLastPrice: [Double]) {
        coinListArray += valueLastPrice
        
        if coinListArray.count == postListArray.count {
            for index in 0..<postListArray.count {
                let temp = coinListArray[index]
                lastValue.append(temp)
            }
            let totalSum = lastValue.reduce(0, +)
            let result = String(format: "%.2f", ceil(totalSum * 100) / 100)
            currentTotalPriceLabel.text = "$ \(result)"
            portfolioValue.text = totalPriceLabel.text
            lastValue.removeAll(keepingCapacity: false)
            portfolioValueLabel.isHidden = false
            portfolioValue.isHidden = false
            changeLabel.isHidden = false
            changeText.isHidden = false
            currentPriceLabel.isHidden = false
            currentTotalPriceLabel.isHidden = false
         
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
                    DispatchQueue.main.async {
                        self.portfolioCollectionView.reloadData()
                    }
                    portfolioCollectionView.isHidden = false
                    
                } else if value1 > value2{
                    let firstOutput = ((value2 - value1) / value1) * 100
                    changeText.text = String(format: "%.2f", ceil(firstOutput * 100) / 100)
                    changeText.textColor = .red
                    DispatchQueue.main.async {
                        self.portfolioCollectionView.reloadData()
                    }
                    portfolioCollectionView.isHidden = false
                }
            }
        }
    }
}
