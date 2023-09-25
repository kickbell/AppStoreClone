//
//  GameCoordinator.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class GameCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = GameViewController()
        vc.tabBarItem = UITabBarItem(
            title: "게임",
            image: UIImage(systemName: "gamecontroller"),
            selectedImage: UIImage(systemName: "gamecontroller.fill")
        )
        vc.tabBarItem.tag = 1
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
