//
//  RequestManager.swift
//  Currency Calculator
//
//  Created by Алексей Авер on 01.08.2022.
//

import UIKit

class RequestManager: NSObject {
    
    static let shared = RequestManager()
    private var urlList = "https://currate.ru/api/?get=currency_list&key="
    private var urlRates = "https://currate.ru/api/?get=rates&pairs="
    
    private var token = "YOUR TOKEN"
    
    
    
    func getList(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: urlList + token) else {return}
        request(to: url) { dictionary in
            
            if let data = dictionary["data"] as? NSArray {
                let objCArray = NSMutableArray(array: data)
                if let swiftArray = objCArray as NSArray as? [String] {
                    completion(swiftArray)
                }
                
            } else {
                print("ERROR PARSE LIST")
            }
        }
    }
    
    func getRates(pairs: String, completion: @escaping ([String:AnyObject]) -> Void) {
        guard let url = URL(string: urlRates + pairs + "&key=" + token) else {return}
        request(to: url) { dictionary in
            
            if let data = dictionary["data"] as? [String:AnyObject] {
                completion(data)
            }
        }
    }
    
    func showAlert(message: String) {
        if let topController = UIApplication.topViewController(),
           (topController is StartViewController ||
            topController is CurrencyViewController) {
            
            let cancel = UIAlertAction(title: "Ok", style: .cancel) { action in
                
            }
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            
            
            alert.addAction(cancel)
            
            DispatchQueue.main.async {
                UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

private extension RequestManager {
    func request(to url: URL, completion: @escaping ([String:Any]) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                print(error)
                DispatchQueue.main.async {
                    completion([:])
                }
                return
            }
            guard let dicData = data,
                  let rezDic = try? JSONSerialization.jsonObject(with: dicData, options: []) as? [String:Any]
            else {
                DispatchQueue.main.async {
                    completion([:])
                }
                return
            }
            DispatchQueue.main.async {
                completion(rezDic)
            }
        }
        dataTask.resume()
    }
    
}
