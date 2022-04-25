//
//  TabBarContollerViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase

class TabBarControllerViewModel {
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }catch {
            print("Error when logout")
        }
    }
}
