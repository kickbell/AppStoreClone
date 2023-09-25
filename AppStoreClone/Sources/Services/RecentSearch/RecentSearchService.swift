//
//  RecentSearchService.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import Foundation

protocol RecentSearchService {
    func read() -> [String]
    func create(text: String) -> String
}

class RecentSearchServiceImp: RecentSearchService {
    private let repository: Storable
    
    init(repository: Storable) {
        self.repository = repository
    }
    
    func read() -> [String] {
        repository.read()
    }
    
    func create(text: String) -> String {
        var newItems = repository.read()
        newItems.insert(text, at: 0)
        repository.save(todos: newItems)
        return text
    }
    
//    func remove(text: String) -> [String] {
//        let newItems = repository.read().filter { $0 != text }
//        repository.save(todos: [])
//        repository.save(todos: newItems)
//        return newItems
//    }
//
//    func removeAll() -> [String] {
//        repository.save(todos: [])
//        return []
//    }
}
