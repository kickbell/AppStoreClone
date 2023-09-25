//
//  MainTabBarController.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class MainTabBarController: UITabBarController {
    let today = TodayCoordinator(navigationController: UINavigationController())
    let game = GameCoordinator(navigationController: UINavigationController())
    let app = AppCoordinator(navigationController: UINavigationController())
    let arcade = ArcadeCoordinator(navigationController: UINavigationController())
    let search = SearchCoordinator(navigationController: UINavigationController())

    override func viewDidLoad() {
        super.viewDidLoad()
        today.start()
        game.start()
        app.start()
        arcade.start()
        search.start()
        
        viewControllers = [
            today.navigationController,
            game.navigationController,
            app.navigationController,
            arcade.navigationController,
            search.navigationController,
        ]
        
        selectedIndex = 4
    }
}
