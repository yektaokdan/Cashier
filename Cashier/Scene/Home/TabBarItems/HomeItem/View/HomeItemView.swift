//
//  HomeItemView.swift
//  Cashier
//
//  Created by yekta on 8.03.2024.
//

import UIKit

class HomeItemView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addCostButtonUI: UIButton!
    @IBOutlet weak var addCostLabel: UILabel!
    @IBOutlet weak var balanceViewUI: UIView!
    @IBOutlet weak var balanceMoneyLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var incomeViewUI: UIView!
    @IBOutlet weak var expenseViewUI: UIView!
    @IBOutlet weak var incomeExpenseView: UIView!
    @IBOutlet weak var incomeLbl: UILabel!
    @IBOutlet weak var expenseLbl: UILabel!
    
    var viewModel=HomeItemViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonsUI()
        setupView()
        setupTableUI()
        setupRoundedCornersForViews()
        viewModel.bindPaymentsToView = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.calculateTotalBalance(labelMoney: balanceMoneyLbl, labelIncome: incomeLbl, labelExpense: expenseLbl)
        
        viewModel.fetchPayments()
    }
    @IBAction func addCostButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addPaymentVC = storyboard.instantiateViewController(withIdentifier: "AddPaymentView") as? AddPaymentView {
            addPaymentVC.modalPresentationStyle = .overFullScreen
            addPaymentVC.modalTransitionStyle = .crossDissolve
            // Modal kapandığında çağrılacak blok
            addPaymentVC.onDismiss = { [weak self] in
                self?.viewModel.fetchPayments() // Verileri yeniden çek
                self?.viewModel.calculateTotalBalance(labelMoney: self!.balanceMoneyLbl, labelIncome: self!.incomeLbl, labelExpense: self!.expenseLbl)
            }
            self.present(addPaymentVC, animated: true, completion: nil)
        }
    }
    
    func setupButtonsUI(){
        let buttons = [addCostButtonUI]
        
        for button in buttons {
            button?.layer.cornerRadius = 25
            button?.layer.masksToBounds = true
        }
    }
    func setupRoundedCornersForViews() {
        roundCorners(view: incomeViewUI, corners: [.topRight, .topLeft], radius: 10)
        roundCorners(view: expenseViewUI, corners: [.bottomRight, .bottomLeft], radius: 10)
        incomeExpenseView.layer.cornerRadius=20
    }
    
    func roundCorners(view: UIView, corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask
    }
    
    func setupView() {
        balanceViewUI.layer.cornerRadius = 15
        balanceViewUI.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        let payment = viewModel.payments[indexPath.row]
        content.text = payment.name
        content.secondaryText = "\(payment.type): \(payment.amount)"
        cell.contentConfiguration = content
        content.textProperties.color = .white
        content.secondaryTextProperties.color = .lightGray
        
        if payment.type == "Expense" {
            content.image = UIImage(named: "expense") // "expense" isimli resmi kullan
        } else if payment.type == "Income" {
            content.image = UIImage(named: "income") // "income" isimli resmi kullan
        }
        content.imageProperties.maximumSize = CGSize(width: 60, height: 60) // Resmin boyutunu ayarlayın
        content.imageProperties.cornerRadius = 30 // Resmi yuvarlak yapmak için
        
        
        
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.backgroundColor = .backgroundDefault
        return cell
    }
    
    func setupTableUI(){
        tableView.backgroundColor = .backgroundDefault
        tableView.separatorColor = .darkGray
        tableView.tintColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
