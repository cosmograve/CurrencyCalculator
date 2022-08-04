//
//  BaseNavigation.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 03.08.2022.
//

import UIKit

class BaseNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let titleFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
        let titleColor = UIColor.black
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: titleFont,
            .foregroundColor: titleColor
        ]
        
        if #available(iOS 13.0, *) {
            let standardAppearance = navigationBar.standardAppearance
            standardAppearance.titleTextAttributes = titleAttributes
            standardAppearance.backgroundColor = UIColor("F5F5F9")
            standardAppearance.backgroundEffect = nil
            standardAppearance.shadowColor = .black.withAlphaComponent(0.5)
            
            navigationBar.tintColor = UIColor("000000")
            navigationBar.standardAppearance = standardAppearance
            navigationBar.scrollEdgeAppearance = standardAppearance
        }
        else {
            navigationBar.backgroundColor = UIColor("F5F5F9")
            navigationBar.barTintColor = UIColor.white
            navigationBar.tintColor = UIColor("000000")
            navigationBar.isTranslucent = false
            navigationBar.titleTextAttributes = titleAttributes
            navigationBar.shadowImage = UIImage()
        }
    }
}

