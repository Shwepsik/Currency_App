//
//  GetCurrencyResponse.swift
//  Currency
//
//  Created by Valerii on 14.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation


class GetCurrencyResponse {
    
    var currency: [CurrencyModel]
   // var defaultPrices: [Double]
    
    var nameCurrency = ["Mexican Peso","Israeli New Shekel","Malaysian Ringgit","Icelandic Króna","Australian Dollar","Pound Sterling","United States Dollar","Swedish Krona","Croatian Kuna","Hong Kong Dollar","Indian Rupee","Hungarian Forint","Thai Baht","Philippine Peso","New Zealand Dollar","Polish Złoty","Indonesian Rupiah","Canadian Dollar","Singapore Dollar","Danish Krone","Euro","Chinese Yuan","South African Rand","Japanese Yen","Swiss Franc","Czech Koruna","Bulgarian Lev","Turkish Lira","Russian Ruble","Brazilian Real","Norwegian Krone","Romanian Leu","South Korean Won"]
    
    var imageCurrency = ["mexico","israel","malaysia","iceland","australia","united-kingdom","united-states","sweden","croatia","hong-kong","india","hungary","thailand","philippines","new-zealand","poland","indonesia","canada","singapore","denmark","european-union","china","south-africa","japan","switzerland","czech-republic","bulgaria","turkey","russia","brazil","norway","romania","south-korea"]

     var signs = ["MXN","ILS","MYR","ISK","AUD","GBP","USD","SEK","HRK","HKD","INR","HUF","THB","PHP","NZD","PLN","IDR","CAD","SGD","DKK","EUR","CNY","ZAR","JPY","CHF","CZK","BGN","TRY","RUB","BRL","NOK","RON","KRW"]
    
    var symbols = ["MX$","₪","RM","kr","A$","£","$","kr","kn","HK$","₹","Ft","฿","₱","NZ$","zł","Rp","CA$","S$","kr","€","CN¥","Rs","J¥","Fr","Kč","лв","₺","₽","R$","kr","lei","₩"]
    
    
    init?(json: JSON) {
        guard let rates = json["rates"] as? JSON else {
            return nil
        }
        
        let currency = rates.map { (arg: (key: String, value: AnyObject)) -> CurrencyModel in
            return CurrencyModel(json: arg)!
        }

        self.currency = currency
        
        self.currency = self.currency.sorted{ signs.index(of: $0.sign)! < signs.index(of: $1.sign)! }
       // self.defaultPrices = currency.map{ ($0.price) }
        
        for i in 0..<self.currency.count {
            self.currency[i].name = nameCurrency[i]
            self.currency[i].image = imageCurrency[i]
            self.currency[i].symbol = symbols[i]
        }
        
        self.currency = self.currency.sorted(by: {$0.name < $1.name } )
        
    }
}
