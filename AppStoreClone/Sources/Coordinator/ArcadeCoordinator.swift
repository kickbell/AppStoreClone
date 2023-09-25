//
//  ArcadeCoordinator.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class ArcadeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ArcadeViewController()
        vc.tabBarItem = UITabBarItem(
            title: "Arcade",
            image: UIImage(systemName: "dpad"),
            selectedImage: UIImage(systemName: "dpad.fill")
        )
        vc.tabBarItem.tag = 3
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
