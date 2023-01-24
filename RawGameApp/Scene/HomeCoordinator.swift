//
//  HomeCoordinator.swift
//  RawGameApp
//
//  Created by kamilcal on 24.01.2023.
//

import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    var filterSelection: ((MovieCategory)->())?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    
    func showFilter() {
        let controller = FilterController.instantiate(name: .main)
        controller.selectionCallback = { [weak self] category in
            self?.filterSelection?(category)
        }
        navigationController.presentPanModal(controller)
    }
}
