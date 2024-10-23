//
//  CalculatorModel.swift
//  Calculator_app
//
//  Created by english on 2024-09-23.
//

import Foundation
import SwiftUI

enum Keys: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    
    // Operations
    case add = "+"
    case substract = "-"
    case divide = "÷"
    case multiply = "x"
    case equal = "="
    
    case clear = "AC"
    case decimal = "."
    case negative = "–/+"
    case percent = "%"
    
    var buttonColor: Color {
        switch self {
        case .add, .substract, .multiply, .divide, .equal:
            return Color.voperator
        case .clear, .negative, .percent:
            return Color.hoperator
        default:
            return Color.num
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

