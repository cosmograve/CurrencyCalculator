//
//  CurrencyViewController.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 03.08.2022.
//

import UIKit

class CurrencyViewController: UIViewController {

    private let changeButton = UIBarButtonItem()
    private var currentIndex = 0
    
    @IBOutlet weak var firstTF: UITextField?
    @IBOutlet weak var secondValue: UILabel?
    @IBOutlet weak var firstValue: UILabel?
    
    @IBOutlet weak var secondTF: UITextField?
    @IBOutlet weak var firstValueView: UIView?
    @IBOutlet weak var secondValueView: UIView?
    
    @IBOutlet weak var refreshButton: BlueButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavItems()
        self.createViews()
        firstTF?.addTarget(self, action: #selector(firstTextFieldTextChanged(_:)), for: .editingChanged)
        secondTF?.addTarget(self, action: #selector(secondTextFieldTextChanged(_:)), for: .editingChanged)
        self.refreshButton?.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
        self.hideKeyboardWhenTappedAround()
        self.navigationItem.title = getCurrentPair()
        self.firstValue?.text = String(getCurrentPair().dropLast(3))
        self.secondValue?.text = String(getCurrentPair().dropFirst(3))
        
        firstTF?.text = "1"
        secondTF?.text = String(getCurrentRate())
    }

    @objc func firstTextFieldTextChanged(_ textField: UITextField) {
        if let value = textField.text?.floatValue {
            secondTF?.text = String(getCurrentRate() * value)
        }
    }
    
    @objc func secondTextFieldTextChanged(_ textField: UITextField) {
        if let value = textField.text?.floatValue {
            firstTF?.text = String(value / (getCurrentRate()))
        }
    }
    
    func getCurrentPair() -> String {
        let pair = CurrencyManager.shared.pairs[currentIndex]
        return(pair)
    }
    
    func getCurrentRate() -> Float {
        var rate: Float = 0
        let rates = CurrencyManager.shared.rates
        rates.forEach { item in
            if item.pair == getCurrentPair() {
                rate = item.rate
                
            }
        
        }
        return(rate)
    }
    
    func setNavItems() {
        self.changeButton.image = UIImage(named: "settings")
        self.changeButton.target = self
        self.changeButton.action = #selector(goToChangePair)
        self.navigationItem.rightBarButtonItem = changeButton
        
        let backItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        backItem.tintColor = UIColor("000000")
        navigationItem.backBarButtonItem = backItem

    }
    
    func createViews() {
        [firstValueView, secondValueView].forEach { view in
            view?.backgroundColor = UIColor("DADADA").withAlphaComponent(0.5)
            view?.layer.cornerRadius = 10
        }
    }
    
    @objc private func goToChangePair() {
        let changeVC = SelectPairViewController()
        changeVC.changePairDelegate = self
        self.navigationController?.pushViewController(changeVC, animated: true)
    }
    @objc private func refreshTapped() {
        CurrencyManager.shared.loadPairs()
        
    }
}

extension CurrencyViewController: ChangePairDelegate {
    func changePair(index: Int) {
        currentIndex = index
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
