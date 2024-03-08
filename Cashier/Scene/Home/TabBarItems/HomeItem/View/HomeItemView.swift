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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonsUI()
        setupView()
        setupTableUI()
        setupRoundedCornersForViews()
    }
    @IBAction func addCostButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addPaymentVC = storyboard.instantiateViewController(withIdentifier: "AddPaymentView") as? AddPaymentView {
            addPaymentVC.modalPresentationStyle = .overFullScreen
            addPaymentVC.modalTransitionStyle = .crossDissolve
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "Head Test"
        content.secondaryText = "Subtitle test"
        cell.contentConfiguration = content
        content.textProperties.color = .white
        content.secondaryTextProperties.color = .lightGray
        
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        cell.backgroundColor = .black
        return cell
    }
    
    func setupTableUI(){
        tableView.backgroundColor = .black
        tableView.separatorColor = .darkGray
        tableView.tintColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}
