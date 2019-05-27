//
//  CalculatorViewController.swift
//  Currency
//
//  Created by Valerii on 17.05.2019.
//  Copyright © 2019 Valerii. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    
    var numberOnScreen : Double = 0
    var previousNumber : Double = 0
    var performingMatch = false
    var doteTaped = false
    var operandActive = false
    var result = Double()
    var operation = Int()
    var newSome = Int()
    var currentInput: Double {
        get {
            let myText = textLable.text?.replacingOccurrences(of: " ", with: "")
            return Double(myText!)!
        } set {
            textLable.text = separateResult(text: String(newValue))
            performingMatch = false
        }
    }
    
    @IBOutlet weak var textLable: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = UIColor(red: 5/255, green: 255/255, blue: 30/255, alpha: 1.0)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func convert(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickNumber(_ sender: UIButton) {
        
        let number = String(sender.tag)
        
        if performingMatch == true {
            if textLable.text!.count < 11 && doteTaped == false {
                textLable.text = textLable.text! + number
                let textString = textLable.text?.replacingOccurrences(of: " ", with: "")
                let newText = textString!
                textLable.text = Int(newText)?.formattedWithSeparator
            } else if textLable.text!.count < 11 {
                textLable.text = textLable.text! + number
            }
            
        } else {
            textLable.text = number
            performingMatch = true
        }
        
    }
    
    func separateResult(text: String) -> String {
        var result = String()
        let valueArray = text.components(separatedBy: ".")
        if valueArray[1] == "0" {
            result = Int(valueArray[0])!.formattedWithSeparator
        } else {
            result = Int(valueArray[0])!.formattedWithSeparator + "." + valueArray[1]
            result = checkLeng(text: result)
        }
        return result
    }
    
    func checkLeng(text: String) -> String {
        var result = String()
        if text.count > 11 {
            let some = text.count - 11
            result = String(text.dropLast(some))
        } else {
            result = text
        }
        return result
    }
    
    func doSome(operation : (Double,Double) -> Double) {
        
        let result = operation(numberOnScreen,previousNumber)
        
        if result > 999999999 {
            currentInput = 0
        } else {
            currentInput = result
        }
        performingMatch = false
    }

    
    @IBAction func result(_ sender: UIButton) {
        doteTaped = false
        if performingMatch == true {
            previousNumber = currentInput
            switch operation {
            case 12: doSome{$0 + $1}
            case 13: doSome{$0 - $1}
            case 14: doSome{$0 * $1}
            case 15:
                if numberOnScreen != 0 && previousNumber != 0 {
                    doSome{$0 / $1}
                }
            default:
                break
                
            }
        }
        if sender.tag == 11 {
            operandActive = false
            operation = 0
        }
    }
    
    @IBAction func zClickOperands(_ sender: UIButton) {
        operation = sender.tag
        numberOnScreen = currentInput
        performingMatch = false
        doteTaped = false
        operandActive = true
    }
    
    
    @IBAction func doteButton(_ sender: UIButton) {
        
        if performingMatch == true && doteTaped == false {
            if textLable.text!.count < 13 {
                textLable.text = textLable.text! + "."
                doteTaped = true
            }
        } else if performingMatch == false && doteTaped == false {
            textLable.text = "0."
            performingMatch = true
            doteTaped = true
        }
    }
    
    
    
    @IBAction func clear(_ sender: UIButton) {
        if operandActive == true {
            operandActive = false
            performingMatch = true
            operation = 0
        } else {
            numberOnScreen = 0
            previousNumber = 0
            currentInput = 0
            textLable.text = "0"
            performingMatch = false
            doteTaped = false
            operation = 0
        }
    }
}
    
    

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}

extension Double {
    func rounded(digits: Int) -> Double {
        let multiplier = pow(10.0, Double(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
