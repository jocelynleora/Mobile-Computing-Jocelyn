//
//  ContentView.swift
//  Calculator
//
//  Created by MacBook Pro on 05/10/23.
//

import SwiftUI

enum CalcButton: String {
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
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"

    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
}

struct ContentView: View {

    @State var value = "0"
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none

    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                // Text display
                HStack {
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()

                // Our buttons
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .font(.system(size: 32))
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight()
                                    )
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item)/2)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }

    func didTap(button: CalcButton) {
           switch button {
           case .add, .subtract, .mutliply, .divide, .equal:
               if button == .add {
                   self.currentOperation = .add
                   if let currentValue = Double(self.value) {
                       self.runningNumber = currentValue
                   } else {
                       self.runningNumber = 0
                   }
               }
               else if button == .subtract {
                   self.currentOperation = .subtract
                   if let currentValue = Double(self.value) {
                       self.runningNumber = currentValue
                   } else {
                       self.runningNumber = 0
                   }
               }
               else if button == .mutliply {
                   self.currentOperation = .multiply
                   if let currentValue = Double(self.value) {
                       self.runningNumber = currentValue
                   } else {
                       self.runningNumber = 0
                   }
               }
               else if button == .divide {
                   self.currentOperation = .divide
                   if let currentValue = Double(self.value) {
                       self.runningNumber = currentValue
                   } else {
                       self.runningNumber = 0
                   }
               }
               else if button == .equal {
                   let currentValue = Double(self.value) ?? 0
                   switch self.currentOperation {
                   case .add: self.value = "\(Int(runningNumber + currentValue))"
                   case .subtract: self.value = "\(Int(runningNumber - currentValue))"
                   case .multiply: self.value = "\(Int(runningNumber * currentValue))"
                   case .divide: self.value = "\(Int(runningNumber / currentValue))"
                   case .none:
                       break
                   }
               }

               if button != .equal {
                   self.value = "0"
               }

        case .clear:
            self.value = "0"
        case .decimal:
            // Append a decimal point (.) if it doesn't already exist
            if !self.value.contains(".") {
                self.value += "."
            }
        case .negative:
            // Toggle between negative and positive values
            if self.value != "0" {
                if self.value.prefix(1) == "-" {
                    self.value.remove(at: self.value.startIndex)
                } else {
                    self.value = "-" + self.value
                }
            }
        case .percent:
            // Divide the current value by 100 to calculate a percentage
            if let currentValue = Double(self.value) {
                self.value = String(currentValue / 100)
            }
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            }
            else {
                self.value = "\(self.value)\(number)"
            }
        }
    }




    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }

    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}


