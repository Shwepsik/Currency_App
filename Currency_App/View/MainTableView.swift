//
//  MainTableView.swift
//  Currency
//
//  Created by Valerii on 16.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import Foundation
import UIKit


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainScreenArray.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainCells
        if editingStyle == .delete {
            myTableView.beginUpdates()
            var currencyArray = UserDefaults.standard.stringArray(forKey: "mainCurrency")
            if let index = currencyArray?.index(of: (cell.nameLable.text)!) {
                currencyArray?.remove(at: index)
                mainScreenArray.remove(at: indexPath.row)
                UserDefaults.standard.set(currencyArray, forKey: "mainCurrency")
            }
            myTableView.deleteRows(at: [indexPath], with: .left)
            myTableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MainCells
        cell.nameLable.text = mainScreenArray[indexPath.row].name
        let price = String(mainScreenArray[indexPath.row].price).components(separatedBy: ".")
        let leftSide = Int(price[0])?.formattedWithSeparator
        cell.priceLable.text = leftSide! + "." + price[1]
        cell.currencyLable.text = mainScreenArray[indexPath.row].symbol
        cell.countryImage.image = UIImage(named: mainScreenArray[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MainCells
        let selectedName = cell.nameLable.text!
        defaultInput = cell.priceLable.text!
        selected = currencyInfo.index{$0.name == cell.nameLable.text} ?? 0
        let calculatorVC = storyboard?.instantiateViewController(withIdentifier: "CalculatorViewController") as! CalculatorViewController
        calculatorVC.navigationItem.title = selectedName
        let navController = UINavigationController(rootViewController: calculatorVC)
        self.present(navController, animated:true, completion: nil)
    }
}
