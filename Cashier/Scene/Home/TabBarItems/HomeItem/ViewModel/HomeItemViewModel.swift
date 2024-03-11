//
//  HomeItemViewModel.swift
//  Cashier
//
//  Created by yekta on 11.03.2024.
//

import Foundation
import Firebase
class HomeItemViewModel {
    
    var payments: [Payment] = [] {
        didSet {
            self.bindPaymentsToView()
        }
    }
    func getCurrentUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    var bindPaymentsToView: (() -> Void) = {}
    
    private var paymentViewModel = PaymentViewModel()
    
    func fetchPayments() {
        guard let userId = Auth.auth().currentUser?.uid else {
            print("Kullanıcı girişi yapılmamış.")
            return
        }
        
        paymentViewModel.fetchPayments(userId: userId) { [weak self] (payments, error) in
            if let payments = payments {
                self?.payments = payments
            } else {
                print(error?.localizedDescription ?? "An error occurred")
            }
        }
    }

    func calculateTotalBalance(labelMoney: UILabel, labelIncome:UILabel, labelExpense:UILabel) {
           guard let userId = Auth.auth().currentUser?.uid else {
               print("Kullanıcı girişi yapılmamış.")
               return
           }

           let db = Firestore.firestore()
           db.collection("payments")
             .whereField("userId", isEqualTo: userId) // Kullanıcıya özgü verileri filtrele
             .getDocuments { (querySnapshot, err) in
               if let err = err {
                   print("Error getting documents: \(err)")
               } else {
                   var totalBalance: Double = 0.0
                   var totalIncome:Double = 0.0
                   var totalExpense:Double = 0.0
                   for document in querySnapshot!.documents {
                       let data = document.data()
                       if let amount = data["amount"] as? Double, let type = data["type"] as? String {
                           if type == "Income" {
                               totalBalance += amount
                               totalIncome += amount
                           } else if type == "Expense" {
                               totalBalance -= amount
                               totalExpense += amount
                           }
                       }
                   }
                   // UI güncellemeleri ana iş parçacığı üzerinde yapılmalı
                   DispatchQueue.main.async {
                       labelMoney.text = "\(totalBalance)₺"
                       labelIncome.text = "\(totalIncome)₺"
                       labelExpense.text = "\(totalExpense)₺"
                   }
               }
           }
       }
    
    
}
