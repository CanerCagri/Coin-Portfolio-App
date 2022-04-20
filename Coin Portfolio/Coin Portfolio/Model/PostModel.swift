//
//  PostModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 19.04.2022.
//

import Foundation

class Post {
    var email : String
    var coinname : String
    var coinquantity : Double
    var totalprice : Double
    
    init(email: String , coinname: String , coinquantity: Double , totalprice: Double ) {
        self.email = email
        self.coinname = coinname
        self.coinquantity = coinquantity
        self.totalprice = totalprice
    }
}
