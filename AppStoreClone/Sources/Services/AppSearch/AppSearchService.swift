//
//  AppSearchService.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/20/23.
//

import Foundation
import RxSwift

protocol AppSearchService {
    func search(country: String, entity: String, limit: String, term: String) -> Observable<[SoftwareDataModel]>
}

final class AppSearchServiceImp: AppSearchService {
    
    private let network: Network
    
    init(network: Network) {
        self.network = network
    }
    
    func search(country: String, entity: String, limit: String, term: String) -> RxSwift.Observable<[SoftwareDataModel]> {
        let request = AppSearchRequest()
        let endpoint = AppSearchEndpoint.apps(country: country, entity: entity, limit: limit, term: term)
        
        return network.send(request, endpoint)
            .map({ response in
                return response.results
            })
    }
}
