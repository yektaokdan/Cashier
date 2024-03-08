//
//  WelcomeViewModel.swift
//  Cashier
//
//  Created by yekta on 7.03.2024.
//

import Foundation
import UIKit
import Firebase

class WelcomeViewModel{
    weak var viewController: UIViewController?
    var email:String?
    var password:String?
    var onLoginSuccess:(()->Void)?
    var onLoginFailure:((Error)->Void)?
    var navigateToScreen: ((String) -> Void)?
    func loginUser() {
        guard let email = email, let password = password else {
            print("E-posta veya şifre boş olamaz")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self?.onLoginFailure?(error)
                }
                return
            }
            
            guard authResult?.user != nil else {
                print("Kullanıcı bilgisi alınamadı.")
                return
            }
            
            print("Giriş başarılı.")
            DispatchQueue.main.async {
                self?.onLoginSuccess?()
            }
        }
    }

    func toRegisterView(toWhere:String){
        viewController?.performSegue(withIdentifier: toWhere, sender: nil)
    }
}
