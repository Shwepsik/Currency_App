//
//  PlusViewController.swift
//  Currency
//
//  Created by Valerii on 16.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import UIKit

class PlusViewController: UIViewController, UISearchBarDelegate {

    var currencySections = [String]()
    var currencyTitles = [String]()
    var currencyDict = [String: [CurrencyModel]]()
    var filtered = [CurrencyModel]()
    var currencyInfo = [CurrencyModel]()
    @IBOutlet weak var myTableVIew: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchBar()
        self.splitArray(array: currencyInfo)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpSearchBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 5/255, green: 255/255, blue: 30/255, alpha: 1.0)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.searchBar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        self.searchBar.layer.borderWidth = 1
        self.searchBar.layer.borderColor = UIColor(red: 5/255, green: 255/255, blue: 30/255, alpha: 1.0).cgColor
        self.searchBar.backgroundColor = UIColor(red: 5/255, green: 255/255, blue: 30/255, alpha: 1.0)
        
    }
    
    
    func splitArray(array : [CurrencyModel]) {
        currencyDict.removeAll()
        for i in array {
            let reqIndex = i.name.index(i.name.startIndex, offsetBy: 1)
            let finalStr = String(i.name[..<reqIndex])
            
            if var filteredValue = currencyDict[finalStr] {
                filteredValue.append(i)
                currencyDict[finalStr] = filteredValue
            } else {
                currencyDict[finalStr] = [i]
            }
        }
        currencySections = [String](currencyDict.keys)
        currencySections = currencySections.sorted(by: {$0 < $1} )
    }
    
    func filterContent(searchText: String) {
        filtered = currencyInfo.filter({ (currency: CurrencyModel) -> Bool in
            let nameMatch = currency.name.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            let symbolMatch = currency.sign.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return nameMatch != nil || symbolMatch != nil
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != "" {
            filterContent(searchText: searchText)
            self.splitArray(array: filtered)
            myTableVIew.reloadData()
        } else {
            self.splitArray(array: currencyInfo)
            myTableVIew.reloadData()
        }
    }
}
