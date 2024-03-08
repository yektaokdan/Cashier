//
//  HomeViewViewController.swift
//  Cashier
//
//  Created by yekta on 8.03.2024.
//

import UIKit

class HomeView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let navigationController = self.navigationController {
            var viewControllers = navigationController.viewControllers
            // Giriş ekranını yığından çıkarmak için
            viewControllers.remove(at: viewControllers.count - 2) // Giriş ekranını çıkar
            navigationController.setViewControllers(viewControllers, animated: true)
        }
    }
    

    

}
