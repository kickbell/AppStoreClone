//
//  TodayCoordinator.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class TodayCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = TodayViewController()
        vc.tabBarItem = UITabBarItem(
            title: "투데이",
            image: UIImage(systemName: "doc.text.image"),
            tag: 0
        )
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
