//
//  Loader.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 04.08.2022.
//

import UIKit

class Loader: NSObject {
    @objc static let shared = Loader()
    private var loaderViewController: UIViewController?
    private override init() {
        super.init()

        setupLoader()
    }
    private func setupLoader() {
        let loaderViewController = UIViewController()
        loaderViewController.view.backgroundColor = UIColor("FFFFFF", alpha: 0.35)
        
        let loader = UIActivityIndicatorView()
        loader.color = .black
        loader.hidesWhenStopped = true
        loader.startAnimating()
        
        loaderViewController.view.addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: loaderViewController.view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: loaderViewController.view.centerYAnchor),
        ])
        self.loaderViewController = loaderViewController
    }
    
    func showLoader(completion: EmptyBlock? = nil) {
        
        guard let loaderViewController = loaderViewController else {
            return
        }

        loaderViewController.modalPresentationStyle = .overFullScreen
        loaderViewController.view.alpha = 0
        guard var topController = UIApplication.shared.keyWindow?.rootViewController else  {
            return
        }
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        
        if topController == loaderViewController {
            return
        }
        
        topController.present(loaderViewController,
                              animated: false,
                              completion: {
            UIView.animate(withDuration: .defaultAnimationTime) {
                self.loaderViewController?.view.alpha = 1
            } completion: { _ in
                completion?()
            }
        })
    }
    
    func removeLoader(completion: EmptyBlock? = nil) {
        UIView.animate(withDuration: .defaultAnimationTime) {
            self.loaderViewController?.view.alpha = 0
        } completion: { _ in
            self.loaderViewController?.dismiss(animated: false, completion: {
                completion?()
            })
        }
    }
}

typealias EmptyBlock = (() -> Swift.Void)

typealias BoolBlock = ((Bool) -> Swift.Void)

func mainThread(block: @escaping EmptyBlock) {
    guard !Thread.isMainThread else {
        block()
        return
    }
    DispatchQueue.main.async(execute: block)
}

extension TimeInterval {
    static var defaultAnimationTime: TimeInterval = 0.3
}
