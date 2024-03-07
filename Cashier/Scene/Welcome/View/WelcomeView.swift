//
//  ViewController.swift
//  Cashier
//
//  Created by yekta on 7.03.2024.
//

import UIKit

class WelcomeView: UIViewController {

    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet weak var title2Label: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginButtonUI: UIButton!
    
    var viewModel=WelcomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonUI()
        setupTextFieldsUI()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        print("deneme")
    }
    
    @IBAction func toRegisterButton(_ sender: Any) {
        viewModel.toRegisterView(toWhere: "toRegisterView")
    }
    
    func setupButtonUI() {
        loginButtonUI.layer.cornerRadius = 20
        loginButtonUI.layer.masksToBounds = true
    }
    func setupTextFieldsUI(){
        let textFields = [emailTxtField, passwordTxtField]
            
            for textField in textFields {
                textField?.layer.cornerRadius = 10
                textField?.layer.masksToBounds = true
                textField?.layer.borderWidth = 1.0
                textField?.layer.borderColor = UIColor.lightGray.cgColor
                textField?.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField?.frame.height ?? 0))
                textField?.leftViewMode = .always
                textField?.translatesAutoresizingMaskIntoConstraints = false
                        textField?.heightAnchor.constraint(equalToConstant: 50).isActive = true
            }
    }
}

