//
//  CalculatorBrain.swift
//  Calculato_hope
//
//  Created by esmart211203 on 06/04/2024.
//

import UIKit
// Dinh nghia lop Model
class CalculatorBrain {
    // MARK: Properties
    // accimulator vua luu toan hang, vua luu ket qua phep toan
    private var accumulator: Double?
    func setOperand(_ operand: Double){
        accumulator = operand
    }
    // Dinh nghia cau truc du lieu de luu tam toan hang va phep toan
    struct Temp {
        let toanhang1: Double
        let phepToam: (Double, Double) -> Double
    }
    // Dinh nghia bien temp
    private var temp:Temp?
    func performOperator(_ mathOperator: String){
            switch mathOperator {
            case "𝛑":
                accumulator = Double.pi
        
            case "e":
                accumulator = M_E
            case "√":
                if let value = accumulator {
                    accumulator = sqrt(value)
                }
            case "Cos":
                if let value = accumulator {
                    accumulator = cos(value)
                }
            case "±":
                if let value = accumulator {
                    accumulator = sign(value)
                }
            case "+":
                if let value = accumulator {
                    temp = Temp(toanhang1: value, phepToam: add)
                    accumulator = nil
                }
            case "-":
                if let value = accumulator {
                    temp = Temp(toanhang1: value, phepToam: sub)
                    accumulator = nil
                }
            case "*":
                if let value = accumulator {
                    temp = Temp(toanhang1: value, phepToam: mul)
                    accumulator = nil
                }
            case "/":
                if let value = accumulator {
                    temp = Temp(toanhang1: value, phepToam: div)
                    accumulator = nil
                }
            case "=":
                if let toanHang2 = accumulator, let temp = temp {
                   accumulator = temp.phepToam(temp.toanhang1, toanHang2)
                    self.temp = nil
                } 
            default:
                break;
            }
    }
    // Dinh nghia phuong thuc cho phep tinh C lay ket qua tu accumulator
    // Cach 1: dung getter
    /**
    func getResult() -> Double?{
        return accumulator
    }
     */
    // Cach 2: use calculator varible
    var result: Double? {
        get {
            return accumulator
        }
    }
    
}
