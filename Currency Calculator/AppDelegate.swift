//
//  AppDelegate.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 31.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var orientationLock = UIInterfaceOrientationMask.all
    static var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    private static var wasEnterAppKey = "wasEnterAppKey"
    static var wasEnterApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: wasEnterAppKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: wasEnterAppKey)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if !AppDelegate.wasEnterApp {
            CurrencyManager.shared.loadPairs()
            openStart()
        } else {
            CurrencyManager.shared.loadUDPairs()
            CurrencyManager.shared.loadUDRates()
            openCurrencies()
        }
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
            
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
    }


    func openStart() {
        let startVC = StartViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = startVC
        window.makeKeyAndVisible()
    }
    
    func openCurrencies() {
        let curVC = CurrencyViewController()
        let welcome = BaseNavigationViewController(rootViewController: curVC)
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = welcome
        window.makeKeyAndVisible()
    }
}

