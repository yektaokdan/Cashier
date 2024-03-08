//
//  RegisterView.swift
//  Cashier
//
//  Created by yekta on 7.03.2024.
//

//if let navigationController = self.navigationController {
//    var viewControllers = navigationController.viewControllers
//    // Giriş ekranını yığından çıkarmak için
//    viewControllers.remove(at: viewControllers.count - 2) // Giriş ekranını çıkar
//    navigationController.setViewControllers(viewControllers, animated: true)
//}

import UIKit
import Firebase
class RegisterView: UIViewController {
    var viewModel = RegisterViewModel()
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var passwordAgainTxtField: UITextField!
    @IBOutlet weak var registerButtonUI: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewController = self
        setupButtonUI()
        setupTextFieldsUI()
    }
    
    
    @IBAction func toLoginButtonTapped(_ sender: Any) {
        viewModel.backButtonTapped()
    }
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let email = emailTxtField.text, !email.isEmpty,
              let password = passwordTxtField.text, !password.isEmpty,
              let passwordAgain = passwordAgainTxtField.text, !passwordAgain.isEmpty else {
            makeAlert(title: "Error", message: "Email, password or password again cannot be null.")
            return
        }
        
        
        guard password == passwordAgain else {
            print("Passwords do not match.")
            return
        }
        
        
        viewModel.email = email
        viewModel.password = password
        viewModel.createUser()
        viewModel.backButtonTapped()
    }
    
    func setupButtonUI() {
        registerButtonUI.layer.cornerRadius = 20
        registerButtonUI.layer.masksToBounds = true
    }
    func setupTextFieldsUI(){
        let textFields = [emailTxtField, passwordTxtField, passwordAgainTxtField]
        
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
    func makeAlert(title: String, message: String, actionTitle: String = "OK") {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
