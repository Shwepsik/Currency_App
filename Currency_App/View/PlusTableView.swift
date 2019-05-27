//
//  PlusTableView.swift
//  Currency
//
//  Created by Valerii on 16.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import UIKit


extension PlusViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return currencySections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return currencySections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key = currencySections[section]
        if let currencyValues = currencyDict[key] {
            return currencyValues.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let cell = tableView.cellForRow(at: indexPath) as! PlusCells
        var currencyArray = UserDefaults.standard.stringArray(forKey: "mainCurrency")
        currencyArray?.append(cell.currencyName.text!)
        currencyArray?.removeDuplicates()
        UserDefaults.standard.set(currencyArray, forKey: "mainCurrency")
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plusCell") as! PlusCells
        let dayKey = currencySections[indexPath.section]
        if let weekDay = currencyDict[dayKey] {
            cell.currencyName.text = weekDay[indexPath.row].name
            cell.currencySymbol.text = weekDay[indexPath.row].sign
            cell.currencyImage.image = UIImage(named: weekDay[indexPath.row].image)
        }
        return cell
    }
    
}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
