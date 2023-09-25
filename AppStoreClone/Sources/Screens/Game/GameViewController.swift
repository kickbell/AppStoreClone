//
//  GameViewController.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class GameViewController: UIViewController {

    weak var coordinator: GameCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "게임"
    }

}
