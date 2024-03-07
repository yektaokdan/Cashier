//
//  WelcomeViewModel.swift
//  Cashier
//
//  Created by yekta on 7.03.2024.
//

import Foundation
import UIKit

class WelcomeViewModel{
    weak var viewController: UIViewController?
    func toRegisterView(toWhere:String){
        viewController?.performSegue(withIdentifier: toWhere, sender: nil)
    }
}
