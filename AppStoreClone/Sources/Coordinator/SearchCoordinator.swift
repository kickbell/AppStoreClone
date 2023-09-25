//
//  SearchCoordinator.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class SearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchViewController()
        vc.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 4
        )
        vc.coordinator = self

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let container = appDelegate.container
        let recentService = container.resolve(RecentSearchService.self)!
        let appService = container.resolve(AppSearchService.self)!
        
        vc.reactor = SearchReactor(
            recentService: recentService,
            appService: appService
        )
        
        navigationController.pushViewController(vc, animated: true)
    }


    
//    func start() {
//        let vc = SearchViewController()
//        vc.tabBarItem = UITabBarItem(
//            title: "검색",
//            image: UIImage(systemName: "magnifyingglass"),
//            tag: 4
//        )
//        vc.coordinator = self
//        vc.reactor = SearchReactor(
//            recentService: RecentSearchServiceImp(repository: UserDefaultService()),
//            appService: AppSearchServiceImp(network: NetworkImp())
//        )
//        navigationController.pushViewController(vc, animated: true)
//    }
    
    func didSelected(with target: SearchViewModel) {
        let searchDetailViewControler = SearchDetailViewControler()
        searchDetailViewControler.configure(with: target)
        navigationController.pushViewController(searchDetailViewControler, animated: true)
    }
}
