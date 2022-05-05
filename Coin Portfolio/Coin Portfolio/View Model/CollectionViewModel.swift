//
//  CollectionViewModel.swift
//  Coin Portfolio
//
//  Created by Caner Çağrı on 25.04.2022.
//

import Foundation
import Firebase

protocol CollectionViewModelProtocol {
    var postList : [PostModel] { get set }
    var postListService: FetchDataFirestore { get }
    var collectionViewControllerDelegate: CollectionViewControllerProtocol? { get }
    
    func setDelegate(collectionVcProtocol: CollectionViewControllerProtocol)
    func fetchAllItems()
}

class CollectionViewModel: CollectionViewModelProtocol {
    
    var collectionViewControllerDelegate: CollectionViewControllerProtocol?
    var postList: [PostModel] = []
    let postListService: FetchDataFirestore
    
    init() {
        postListService = FetchDataFirestore()
    }
    
    func setDelegate(collectionVcProtocol: CollectionViewControllerProtocol) {
        collectionViewControllerDelegate = collectionVcProtocol
    }
    
    func fetchAllItems() {
        postList.removeAll()
        postListService.fetchData {[weak self] response in
            self?.postList = response ?? []
            self?.collectionViewControllerDelegate?.saveDatas(values: self?.postList ?? [])
        }
    }
}

