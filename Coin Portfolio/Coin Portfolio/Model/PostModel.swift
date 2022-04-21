//
//  PostModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 19.04.2022.
//

import Foundation

class PostModel {
    var email : String
    var coinname : String
    var coinquantity : Double
    var totalprice : String
    
    init(email: String , coinname: String , coinquantity: Double , totalprice: String ) {
        self.email = email
        self.coinname = coinname
        self.coinquantity = coinquantity
        self.totalprice = totalprice
    }
}
