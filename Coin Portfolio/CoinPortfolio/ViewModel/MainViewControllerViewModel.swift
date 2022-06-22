//
//  ViewControllerViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase

class MainViewControllerViewModel {
    
    func login(email: String , password: String, completion: @escaping (Bool) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password )  { result, error in
            if error == nil {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
