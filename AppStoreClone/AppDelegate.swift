//
//  AppDelegate.swift
//  AppStoreClone
//
//  Created by jc.kim on 9/19/23.
//

import UIKit
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupDependencies()

        return true
    }
    
    private func setupDependencies() {
        container.register(Network.self) { _ in NetworkImp() }
        container.register(UserDefaultService.self) { _ in UserDefaultService() }
        container.register(RecentSearchService.self) { r in
            RecentSearchServiceImp(repository: r.resolve(UserDefaultService.self)!)
        }
        container.register(AppSearchService.self) { r in
            AppSearchServiceImp(network: r.resolve(Network.self)!)
        }
    }

}
