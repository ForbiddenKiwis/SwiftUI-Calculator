//
//  KeyView.swift
//  Calculator_app
//
//  Created by english on 2024-09-23.
//

import SwiftUI

struct KeyView: View {
    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
    @State private var changeColor = false
    
    let buttons: [[Keys]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.six, .five, .four, .substract],
        [.three, .two, .one, .add ],
        [.zero, .decimal, .equal]
    ]
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(changeColor ? Color.num: Color.pink.opacity(0.2))
                    .scaleEffect(changeColor ? 1.5 : 1 )
                    .frame(width: 350, height: 280)
                    .animation(Animation.easeInOut.speed(0.17).repeatForever(), value: changeColor)
                    .onAppear(perform: {
                        self.changeColor.toggle()
                    }).overlay(
                        Text(value)
                            .font(.system(size: 100))
                            .foregroundStyle(.black)
                    )
            }.padding()
            
            ForEach(buttons, id: \.self){
                row in
                HStack(spacing: 12){
                    ForEach(row, id: \.self){
                        element in
                        Button(action: {
                            self.didTap(button: element)
                        }, label: {
                            Text(element.rawValue)
                                .font(.system(size: 30))
                                .frame(width: self.getWidth(element: element), height: self.getHeight(element: element))
                                .background(element.buttonColor)
                                .foregroundStyle(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .shadow(color: .purple.opacity(0.5), radius: 30)
                        })
                    }
                }.padding(.bottom, 4)
            }
        }
    }
    
    func getWidth(element: Keys) ->  CGFloat {
        if element == .zero {
            return (UIScreen.main.bounds.width - (5*10)) / 2
        }
        
        return (UIScreen.main.bounds.width - (5*10)) / 4
    }
    
    func getHeight(element: Keys) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*10)) / 5
    }
    
    func didTap(button: Keys) {
        switch button{
        case .add, .substract, .multiply, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .substract {
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .divide {
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0
                
                switch self.currentOperation {
                case .add:
                    self.value = "\(runningValue + currentValue)"
                case .subtract:
                    self.value = "\(runningValue - currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .divide:
                    self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            if button != .equal {
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            break
        case .decimal, .negative, .percent:
            // To Do
            
            let runningValue = self.runningNumber
            let currentValue = Double(self.value) ?? 0
            
            if button == .negative {
                if runningNumber < 0 {
                    value = "\(currentValue * (-1))"
                } else {
                    value = "\(-1 * currentValue)"
                }
            } else if button == .decimal {
                if (!value.contains(".")) {
                    value += "."
                }
            } else if button == .percent {
                value = "\(currentValue/100)"
            }
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        KeyView()
    }
}
