//
//  UserDefaultService.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import Foundation

protocol Storable {
    func read() -> [String]
    func save(todos: [String])
}

class UserDefaultService: Storable {
    typealias RecentSearchType = String
    
    private let key = String(describing: RecentSearchType.self)
    private var database: UserDefaults { UserDefaults.standard }
    
    func read() -> [RecentSearchType] {
        guard let json = UserDefaults.standard.string(forKey: key),
              let data = json.data(using: .utf8) else {
            return []
        }
        return (try? JSONDecoder().decode([RecentSearchType].self, from: data)) ?? []
    }
    
    func save(todos: [RecentSearchType]) {
        guard let data = try? JSONEncoder().encode(todos),
              let json = String(data: data, encoding: .utf8) else {
            return
        }
        UserDefaults.standard.set(json, forKey: key)
    }
}
