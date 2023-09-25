//
//  TodayViewController.swift
//  ApoStoreClone
//
//  Created by ksmartech on 2023/09/19.
//

import UIKit

class TodayViewController: UIViewController {

    weak var coordinator: TodayCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
        title = "투데이"
    }
    
}
