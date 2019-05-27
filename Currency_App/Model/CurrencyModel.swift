//
//  CurrencyModel.swift
//  Currency
//
//  Created by Valerii on 14.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation

struct CurrencyModel {
    
    var sign: String
    var price: Double
    var name: String
    var image: String
    var symbol: String
    
    init?(json: (key: String, value: AnyObject)) {
        
        self.sign = json.key
        let convert = json.value as! Double
        if convert > 100.00 {
            self.price = convert.rounded(digits: 2)
        } else if convert < 10 {
            self.price = convert.rounded(digits: 6)
        } else {
            self.price = convert.rounded(digits: 4)
        }
        self.name = ""
        self.image = ""
        self.symbol = ""
    }
}
