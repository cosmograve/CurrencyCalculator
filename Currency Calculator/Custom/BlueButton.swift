//
//  BlueButton.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 03.08.2022.
//

import UIKit

class BlueButton: UIButton {
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupButton()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 0.93, y: 0.93)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.1) {
            self.transform = .identity
        }
    }

    func setupButton() {
        if #available(iOS 15.0, *) {
            self.configuration = .none
        }
        self.layer.backgroundColor = UIColor("007AFF").cgColor
        self.layer.cornerRadius = 10
        self.setTitleColor(UIColor("FFFFFF"), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleLabel?.minimumScaleFactor = 0.5
        
    }
    

}

