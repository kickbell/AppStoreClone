//
//  AppViewController.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class AppViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "앱"
    }

}
