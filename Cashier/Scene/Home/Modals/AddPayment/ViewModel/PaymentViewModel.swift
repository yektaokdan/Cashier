//
//  PaymentViewModel.swift
//  Cashier
//
//  Created by yekta on 11.03.2024.
//

import Foundation
import Firebase

class PaymentViewModel {
    func addPayment(payment: Payment, completion: @escaping (Bool, Error?) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı girişi yapılmamış"]))
            return
        }
        
        let db = Firestore.firestore()
        db.collection("payments").addDocument(data: [
            "userId": userId,
            "name": payment.name,
            "type": payment.type,
            "amount": payment.amount,
            "createdAt": FieldValue.serverTimestamp()
        ]) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
    
    func fetchPayments(userId: String, completion: @escaping ([Payment]?, Error?) -> Void) {
        let db = Firestore.firestore()
        db.collection("payments")
          .whereField("userId", isEqualTo: userId)
          .getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var payments = [Payment]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let name = data["name"] as? String ?? ""
                    let type = data["type"] as? String ?? ""
                    let amount = data["amount"] as? Double ?? 0.0
                    let payment = Payment(name: name, type: type, amount: amount)
                    payments.append(payment)
                }
                completion(payments, nil)
            }
        }
    }

}

