//
//  AddPaymentView.swift
//  Cashier
//
//  Created by yekta on 8.03.2024.
//

import UIKit

class AddPaymentView: UIViewController {
    
    var selectedType: String?
    @IBOutlet weak var saveButtonUI: UIButton!
    @IBOutlet weak var incomeButton: UIButton!
    @IBOutlet weak var expenseButton: UIButton!
    @IBOutlet weak var amountTxtFld: UITextField!
    @IBOutlet weak var paymentNameTxtFld: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
        setupBlurEffect()
        setupCancelButton()
        setupButtonUI()
        selectedType = "Income"
        updateUI()
        
        //for keyboard
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false // Bu, diğer kontrollerin dokunma olaylarını etkilememesini sağlar
            view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true) // Bu, aktif olan klavyeyi kapatır
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        // Klavyenin view'in altından ne kadar yüksekte olduğunu hesaplayın
        let bottomSpace = self.view.frame.size.height - (amountTxtFld.frame.origin.y + amountTxtFld.frame.size.height)
        
        // Eğer klavye text field'ı örtüyorsa, view'i yukarı kaydır
        if keyboardSize.height > bottomSpace {
            self.view.frame.origin.y = 0 - keyboardSize.height + bottomSpace
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        // Klavye gizlendiğinde view'in konumunu sıfırla
        self.view.frame.origin.y = 0
    }

    
    func setupButtonUI(){
        saveButtonUI.layer.cornerRadius = 15
        saveButtonUI.layer.masksToBounds = true
    }
    func setupCancelButton(){
        let closeButton = UIButton(frame: CGRect(x: 20, y: 50, width: 80, height: 40))
        closeButton.setTitle("Cancel", for: .normal)
        closeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        closeButton.setTitleColor(.incomeView, for: .normal)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    func setupBlurEffect(){
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.insertSubview(blurEffectView, at: 0)
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
    }
    
    @IBAction func inComeSelected(_ sender: Any) {
        selectedType = "Income"
        updateUI()
    }
    
    @IBAction func expenseSelected(_ sender: Any) {
        selectedType = "Expense"
        updateUI()
    }
    
    func updateUI() {
        if selectedType == "Income" {
            incomeButton.backgroundColor = .incomeView
            incomeButton.tintColor = .white
            expenseButton.backgroundColor = .white
            expenseButton.tintColor = .black
        } else if selectedType == "Expense" {
            expenseButton.backgroundColor = .incomeView
            expenseButton.tintColor = .white
            incomeButton.backgroundColor = .white
            incomeButton.tintColor = .black
        } else {
            incomeButton.backgroundColor = .white
            incomeButton.tintColor = .black
            expenseButton.backgroundColor = .white
            expenseButton.tintColor = .black
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
