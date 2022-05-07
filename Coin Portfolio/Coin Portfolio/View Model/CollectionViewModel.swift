//
//  CollectionViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase

protocol CollectionViewModelProtocol: AnyObject {
    var postList : [PostModel] { get set }
    var postListService: FetchDataFirestore { get }
    func fetchAllItems()
    func postDeleteDocument(selectedCoin : String)
  
}
protocol CollectionViewModelOutput: AnyObject {
    func updateView(valuePostList : [PostModel])
}

class CollectionViewModel: CollectionViewModelProtocol {
    weak var output : CollectionViewModelOutput?

    var postList: [PostModel] = []
    let postListService: FetchDataFirestore
    let postDeleteService : DeleteDataFirestore
    
    init() {
        postListService = FetchDataFirestore()
        postDeleteService = DeleteDataFirestore()
    }
    func postDeleteDocument(selectedCoin : String) {
        postDeleteService.deleteData(selectedCoin: selectedCoin)
    }

    func fetchAllItems() {
        postList.removeAll()
        postListService.fetchData {[weak self] response in
            self?.output?.updateView(valuePostList: response ?? [])
        }
    }
}

