//
//  FirestoreService.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 26.04.2022.
//

import Foundation
import Firebase

protocol DeleteDataFirestoreProtocol {
    func deleteData(selectedCoin : String)
}

protocol FetchDataFirestoreProtocol {
    func fetchData(completion:@escaping ([PostModel]?) -> Void)
}

protocol AddDataFirestoreProtocol {
    func addData(selectedCoin : String , selectedCoinQuantity: Double, totalPrice: String)
}

protocol UpdateDataFirestoreProtocol {
    func updateData (selectedCoinId : String, coinname: String, coinquantity: Double, totalprice: String)
}

let db = Firestore.firestore()
let firestoreConstants = FirestoreConstants()

class UpdateDataFirestore: UpdateDataFirestoreProtocol {
    func updateData (selectedCoinId : String, coinname: String, coinquantity: Double, totalprice: String) {
        
        db.collection(firestoreConstants.collectionName).whereField(firestoreConstants.id, isEqualTo: selectedCoinId).getDocuments { result, error in
            if error == nil {
                for document in result!.documents {
                    db.collection(firestoreConstants.collectionName).document(document.documentID).setData([firestoreConstants.coinname: coinname, firestoreConstants.coinquantity: coinquantity, firestoreConstants.totalprice: totalprice], merge: true)
                }
            }
        }
    }
}

class DeleteDataFirestore: DeleteDataFirestoreProtocol {
    func deleteData(selectedCoin : String) {
        db.collection(firestoreConstants.collectionName).whereField(firestoreConstants.id, isEqualTo: "\(selectedCoin)").getDocuments { (snapshot, err) in
            
            if let err = err {
                fatalError(err.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    if document == document {
                        db.collection(firestoreConstants.collectionName).document(document.documentID).delete()
                    }
                }
            }
        }
    }
}

class AddDataFirestore: AddDataFirestoreProtocol {
    func addData(selectedCoin : String , selectedCoinQuantity: Double, totalPrice: String) {
        db.collection(firestoreConstants.collectionName).addDocument(data: [firestoreConstants.id: UUID().uuidString , firestoreConstants.email: Auth.auth().currentUser!.email! , firestoreConstants.coinname: selectedCoin , firestoreConstants.coinquantity : selectedCoinQuantity , firestoreConstants.totalprice : totalPrice , firestoreConstants.date: FieldValue.serverTimestamp()]) { error in
            if error == nil {
                return
            } else {
                fatalError(error!.localizedDescription)
            }
        }
    }
}

class FetchDataFirestore : FetchDataFirestoreProtocol {
    
    var posts: [PostModel] = []
    
    func fetchData(completion: @escaping ([PostModel]?) -> Void) {
        let userEmail = Auth.auth().currentUser?.email
        
        Firestore.firestore().collection(firestoreConstants.collectionName).getDocuments(completion: {  snapshot, err in
            if err != nil {
                print(err!.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.posts.removeAll()
                    for document in snapshot!.documents {
                        if let email = document.get(firestoreConstants.email) as? String {
                            // If current mail and firestore mail matching
                            if email == userEmail {
                                if let coinName = document.get(firestoreConstants.coinname) as? String {
                                    if let coinquantity = document.get(firestoreConstants.coinquantity) as? Double {
                                        if let id = document.get(firestoreConstants.id) as? String {
                                            if let totalprice = document.get(firestoreConstants.totalprice) as? String {
                                                self.posts.append(PostModel(id: id, email: email, coinname: coinName, coinquantity: coinquantity, totalprice: totalprice))
                                            }
                                        }
                                    }
                                }
                            } else {
                            }
                        }
                    }
                    completion(self.posts)
                }
            }
        })
    }
}
