//
//  CurrencyManager.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 02.08.2022.
//

import UIKit

struct RateItems: Codable {
    var pair: String
    var rate: Float
}

class CurrencyManager: NSObject {
    
    @objc dynamic var isLoadData = false
    
    var pairs = [String]()
    var rates = [RateItems]()
    static let shared = CurrencyManager()
    
    func loadPairs() {
        Loader.shared.showLoader()
        RequestManager.shared.getList { arrayPairs in
            self.pairs = arrayPairs
            self.savePairs()
            self.loadRates()
            
        }
        
    }
    
    func loadRates() {
        let pairsString = pairs.joined(separator: ",")
        RequestManager.shared.getRates(pairs: pairsString) { dictionary in
            var rateItem = RateItems(pair: "", rate: 0)
            dictionary.forEach { (key: String, value: AnyObject) in
                guard let value = value as? String else {
                    return}
                rateItem = RateItems(pair: key, rate: Float(value) ?? 0)
                self.rates.append(rateItem)
            }
            self.saveRates()
            self.isLoadData = true
            Loader.shared.removeLoader()
        }
    }

    func savePairs() {
        guard pairs.count > 0 else {return}
        let encodedData = try? JSONEncoder().encode(pairs)
        UserDefaults.standard.set(encodedData, forKey: "pairsKey")
        UserDefaults.standard.synchronize()
    }
    
    func saveRates() {
        guard rates.count > 0 else {return}
        let encodedData = try? JSONEncoder().encode(rates)
        UserDefaults.standard.set(encodedData, forKey: "ratesKey")
        UserDefaults.standard.synchronize()
    }
    
    func loadUDPairs() -> Bool {
        guard let data = UserDefaults.standard.data(forKey: "pairsKey") else {return false}
        pairs = try! JSONDecoder().decode([String].self, from: data)
        return true
    }
    
    func loadUDRates() -> Bool {
        guard let data = UserDefaults.standard.data(forKey: "ratesKey") else {return false}
        rates = try! JSONDecoder().decode([RateItems].self, from: data)
        return true
    }
}

