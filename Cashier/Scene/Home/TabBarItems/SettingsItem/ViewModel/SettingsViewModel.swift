//
//  SettingsViewModel.swift
//  Cashier
//
//  Created by yekta on 8.03.2024.
//

import Foundation
import Firebase
class SettingsViewModel{
    func signOut(completion: @escaping (Error?) -> Void) {
            do {
                try Auth.auth().signOut()
                completion(nil)
                print("Exit process")
            } catch let signOutError {
                completion(signOutError)
            }
        }
}
