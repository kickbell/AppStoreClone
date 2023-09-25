//
//  AppCoordinator.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = AppViewController()
        vc.tabBarItem = UITabBarItem(
            title: "앱",
            image: UIImage(systemName: "rectangle.on.rectangle"),
            selectedImage: UIImage(systemName: "rectangle.on.rectangle.fill")
        )
        vc.tabBarItem.tag = 2
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
