//
//  ArcadeViewController.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class ArcadeViewController: UIViewController {

    weak var coordinator: ArcadeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "Arcade"
    }

}
