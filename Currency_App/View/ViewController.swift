//
//  ViewController.swift
//  Currency
//
//  Created by Valerii on 13.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var currencyInfo = [CurrencyModel]()
    var mainScreenArray = [CurrencyModel]()
    var defaultInput = String()
    var defaultPrices = [Double]()
    var selel = String()
    var selected = Int()
    var check = String()

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 5/255, green: 255/255, blue: 30/255, alpha: 1.0)
        RequestController.shared.tryLoadCurrency { (model) in
            self.currencyInfo = model.currency
            self.defaultPrices = model.currency.map{ ($0.price) }
            self.mainScreenArray = model.currency.filter{ (UserDefaults.standard.stringArray(forKey: "mainCurrency")?.contains($0.name))! }
            self.myTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.mainScreenArray = currencyInfo.filter{ (UserDefaults.standard.stringArray(forKey: "mainCurrency")?.contains($0.name))! }
        self.myTableView.reloadData()
    }
    
    @IBAction func unwindFromCalc(sender: UIStoryboardSegue) {
        if sender.source is CalculatorViewController {
            if let calculatorVC = sender.source as? CalculatorViewController {
                if calculatorVC.currentInput > 0 {
                    currencyInfo.enumerated().forEach { (index, value) in
                        if value.price == Double(defaultInput) {
                            currencyInfo[index].price = calculatorVC.currentInput
                        } else {
                            currencyInfo[index].price = (defaultPrices[index] * calculatorVC.currentInput)/defaultPrices[selected]
                            currencyInfo[index].price = roundResult(price: currencyInfo[index].price)
                        }
                    }
                }
            }
        }
    }
    
    func roundResult(price: Double) -> Double {
        var round = Double()
        if price > 100.00 {
            round = price.rounded(digits: 2)
        } else if price < 10.00 {
            round = price.rounded(digits: 6)
        } else {
            round = price.rounded(digits: 4)
        }
        return round
    }
    
    @IBAction func pushPlusView(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let plusView = storyBoard.instantiateViewController(withIdentifier: "PlusViewController") as! PlusViewController
        plusView.currencyInfo = self.currencyInfo
        let navController = UINavigationController(rootViewController: plusView)
        self.present(navController, animated:true, completion: nil)
    }
}

