//
//  StartViewController.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 31.07.2022.
//

import UIKit

class StartViewController: UIViewController {
    private var CurrencyManagerObserver: NSKeyValueObservation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeStart()
    }
    
    func observeStart() {
        CurrencyManagerObserver = CurrencyManager.shared.observe(\.isLoadData) { [weak self] _, _ in
            self?.gotoCurrency()
        }
    }
    
    private func gotoCurrency() {
        if CurrencyManager.shared.isLoadData {
            openCurrencies()
        }
    }
    
    private func openCurrencies() {
        AppDelegate.wasEnterApp = true
        let curVC = CurrencyViewController()
        let welcome = BaseNavigationViewController(rootViewController: curVC)
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        window.rootViewController = welcome
        window.makeKeyAndVisible()
        UIView.animate(withDuration: 0.25) {
            window.alpha = 1
        } completion: { (_) in
            AppDelegate.appDelegate.window = window
            
        }
        
    }
}
