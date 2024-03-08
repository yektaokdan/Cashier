//
//  SettingsView.swift
//  Cashier
//
//  Created by yekta on 8.03.2024.
//

import UIKit

class SettingsItemView: UIViewController {
    
    @IBOutlet weak var logoutButtonUI: UIButton!
    var viewModel = SettingsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonUI()
    }
    @IBAction func logoutButtonTapped(_ sender: Any) {
        signOutTapped()
    }
    
    func setupButtonUI(){
        logoutButtonUI.layer.cornerRadius = 15
        logoutButtonUI.layer.masksToBounds = true
        logoutButtonUI.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    @objc func signOutTapped() {
        viewModel.signOut { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Çıkış yaparken hata oluştu: \(error.localizedDescription)")
                } else {
                    guard let self = self else { return }
                    // Çıkış başarılı, ana ekrana yönlendir
                    self.navigateToWelcomeView()
                }
            }
        }
    }
    
    func navigateToWelcomeView() {
        if let welcomeViewController = storyboard?.instantiateViewController(withIdentifier: "welcomeView") {
            UIApplication.shared.keyWindow?.rootViewController = welcomeViewController
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            let duration: TimeInterval = 0.3
            UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {}, completion: { completed in
                
            })
        }
    }
    
    
}
