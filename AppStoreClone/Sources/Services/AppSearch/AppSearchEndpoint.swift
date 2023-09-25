//
//  AppSearchEndpoint.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/20/23.
//

import Foundation

enum AppSearchEndpoint {
    case apps(
        country: String,
        entity: String,
        limit: String,
        term: String
    )
}

extension AppSearchEndpoint: EndPoint {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "itunes.apple.com"
    }
    
    var path: String {
        switch self {
        case .apps: return "/search"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .apps: return .get
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []

        switch self {
        case let .apps(country, entity, limit, term):
            queryItems.append(URLQueryItem(name: "country", value: country))
            queryItems.append(URLQueryItem(name: "entity", value: entity))
            queryItems.append(URLQueryItem(name: "limit", value: limit))
            queryItems.append(URLQueryItem(name: "term", value: term))
        }
        return queryItems
    }
}

