//
//  ViewController.swift
//  Calculato_hope
//
//  Created by esmart211203 on 22/03/2024.
//

import UIKit

class CalculatorController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var display: UILabel!
    private var isTypeing = false

    // MARK: Calculator's Methods
    @IBAction func digitProcesing(_ sender: UIButton) {
        let digit = sender.titleLabel!.text!
        let displayText = display.text!
        if isTypeing {
            // Nôí phím
            display.text = displayText + digit
        }else {
            display.text = digit
            if digit != "0" {
                isTypeing = true
            }
        }
    }
    
    //dinh nghia bien tinh toan thay the ccho man hinh dísplay
    private var displayValue:Double? {
        // calculatorVarible {get;set}
        get{
            if let displayText = display.text , let value = Double(displayText){
                return value
            }else{
                return nil
            }
        }
        set{
            if let newValue = newValue {
                // biến input thành chuỗi và hiện ra màn hình
                let n = newValue.soChuSoPhanNguyen()
                let tp = newValue.soChuSoPhanThapPhan()
                let maxLengthNumber: Int = 14
                let minNumber: Int = 0
                if n + tp <= maxLengthNumber {
                    if tp == minNumber {
                        display.text = String(format: "%0.0f", newValue)
                    }else{
                        display.text = String(newValue)
                    }
                }
                else {
                    if tp == 0 {
                        display.text = String(format: "%0.0f", newValue)
                    }else{
                        display.text = String(format: "%0.\(maxLengthNumber-n)f", newValue)
                    }
                }
            }
        }
    }
    // Dinh nghia tham chieu den Model
    private let calBrain = CalculatorBrain()
    
    // MARK: Ham xu ly phim chuc nang
    @IBAction func functionProcessing(_ sender: UIButton) {
        
        // phep tinh dc lay luu vao funcName
        let functionName = sender.titleLabel!.text!
        
        // B1. Truyen gia tri toan hang sang M
        if isTypeing || !isTypeing && display.text == "0"{
            if let value = displayValue {
                calBrain.setOperand(value)
            }
        }
        
        // B2. truyen phep toam samg M va yeu cau thuc hien
        calBrain.performOperator(functionName)
        
        // B3. Lay ket qua phep toan tu
        displayValue = calBrain.result
        
        // Xoa trang thai phim so
        isTypeing = false
    }
}
func sign(_ x: Double) -> Double {
    return x == 0 ? 0 : -x
}
func add(toanHang1 a:Double, toanHang2 b:Double) -> Double {
    return a + b
}

func sub(soBiTru a:Double, soTru b:Double) -> Double {
    return a - b
}

func mul(toanHang1 a:Double, toanHang2 b:Double) -> Double {
    return a * b
}

func div(soBiChia a:Double, soChia b:Double) -> Double {
    return a / b
}

// Mo rong chuc nang cho lop Double
extension Double {
    func soChuSoPhanNguyen() -> Int {
        if !self.isNaN {
            let chuoiSoThuc = String(self)
            let phanNguyen = chuoiSoThuc.split(separator: ".")[0]
            return phanNguyen.count
        }else{
            return -1
        }
    }
    
    func soChuSoPhanThapPhan() -> Int {
        if !self.isNaN && self.isFinite	 {
            let chuoiSoThuc = String(self)
            let phanThapPhan = chuoiSoThuc.split(separator: ".")[1]
            return phanThapPhan == "0" ? 0 : phanThapPhan.count
        }else{
            return -1
        }
    }
}
