//
//  RequestController.swift
//  Currency
//
//  Created by Valerii on 13.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import Alamofire


typealias JSON = [String: AnyObject]
typealias ResponseBlock = (_ result: Any?, _ error: Error?)
    -> Void


class RequestController {
    
    static let shared = RequestController()
    
    
    let baseUrl: String = "https://api.exchangeratesapi.io/"
    
    
    func tryLoadInfo(method: HTTPMethod, params: Parameters?, headers: HTTPHeaders?, path: String, responseBlock: @escaping ResponseBlock) {
        
        let fullPath: String = baseUrl + path
        
        if let url: URL = URL(string: fullPath) {
            
            request(url, method: method, parameters: params, headers: headers).validate().responseJSON { (responseJSON) in
                switch responseJSON.result {
                case .success:
                    guard let jsonArray = responseJSON.result.value as? JSON else {
                        return
                    }
                    responseBlock(jsonArray,nil)
                    
                case .failure(let error):
                    print(error)
                    responseBlock(nil,error)
                    
                }
            }
        }
    }
    
    func tryLoadCurrency(_ responseBlock: @escaping (GetCurrencyResponse) -> Void) {
        tryLoadInfo(method: .get, params: ["base": "USD"], headers: nil, path: "latest") { (response, error) in
            if let json = response as? JSON {
                let currencyResponse = GetCurrencyResponse(json: json)
                responseBlock(currencyResponse!)
            }
        }
    }
}
