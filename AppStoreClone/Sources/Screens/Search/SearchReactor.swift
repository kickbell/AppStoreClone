//
//  SearchReactor.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa

final class SearchReactor: Reactor {
    enum Action {
        case saveRecentQuery(String)
        case updateRecentQuery(String)
        case updateAppQuery(String)
    }
    
    enum Mutation {
        case setQuery(String?)
        case setDisplayItems([DisplayItem])
        case setLoading(Bool)
        case setError(Error?)
    }
    
    struct State {
        var query: String?
        var displayItems: [DisplayItem]
        var isLoading: Bool = false
        var error: Error?
    }
    
    let initialState = State(displayItems: [])
    
    private let recentService: RecentSearchService
    private let appService: AppSearchService
    
    init(
        recentService: RecentSearchService,
        appService: AppSearchService
    ) {
        self.recentService = recentService
        self.appService = appService
    }
}

extension SearchReactor {
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .saveRecentQuery(query):
            if !recentService.read().contains(query) {
                _ = recentService.create(text: query)
            }
            return Observable.just(Mutation.setQuery(query))
        case let .updateRecentQuery(query):
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                Observable.just(
                    recentService.read()
                        .filter { query.isEmpty ? true : $0.contains(query) }
                )
                .map {
                    $0.map { DisplayItem(type: .recent($0)) }
                }
                .map { Mutation.setDisplayItems($0) },
//                .catch { Observable.just(Mutation.setError($0)) },
                
                Observable.just(Mutation.setLoading(false)),
            ])
        case let .updateAppQuery(query):
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                
                appService.search(country: "kr", entity: "software", limit: "25", term: query)
                    .map({ responds -> [SearchViewModel] in
                        let results: [SoftwareDataModel] = responds
                        // 비동기 이미지 로드 및 ViewModel 변환
                        let viewModels = results.compactMap { softwareData in
                            var viewModel: SearchViewModel?
                            let group = DispatchGroup()
                            
                            group.enter()
                            softwareData.toViewModel { resultViewModel in
                                viewModel = resultViewModel
                                group.leave()
                            }
                            // 대기 후 ViewModel 반환
                            group.wait()
                            return viewModel
                        }
                        return viewModels
                    })
                    .map({ viewModels in
                        viewModels.map { DisplayItem(type: .app($0)) }
                    })
                    .map { Mutation.setDisplayItems($0) },
//                    .catch { Observable.just(Mutation.setError($0)) },
                
                Observable.just(Mutation.setLoading(false)),
            ])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setQuery(query):
            var newState = state
            newState.query = query
            return newState
        case let .setDisplayItems(displayItems):
            var newState = state
            newState.displayItems = displayItems
            return newState
        case let .setLoading(isLoading):
            var newState = state
            newState.isLoading = isLoading
            return newState
        case let .setError(error):
            var newState = state
            newState.error = error
            return newState
        }
    }
}


extension SearchReactor {
    struct DisplayItem: Equatable {
        enum ItemType: Equatable {
            case app(SearchViewModel)
            case recent(String)
            
            var isRecent: Bool {
                if case .recent = self { return true }
                return false
            }
            
            var isApp: Bool {
                if case .app = self { return true }
                return false
            }
            
            var recentValue: String? {
                switch self {
                case .recent(let text):
                    return text
                default:
                    return nil
                }
            }
            
            var appValue: SearchViewModel? {
                switch self {
                case .app(let appData):
                    return appData
                default:
                    return nil
                }
            }
        }
        
        let type: ItemType
    }
}
