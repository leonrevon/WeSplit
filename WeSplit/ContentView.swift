//
//  ContentView.swift
//  WeSplit
//
//  Created by Leon Teng on 17.05.22.
//

import SwiftUI

struct ContentView: View {
    @State private var billAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    @FocusState private var billAmountIsFocused: Bool
    
    var totalPerPerson: Double {
        
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = billAmount / 100 * tipSelection
        let grandTotal = billAmount + tipValue
        
        let amountPerPerson = grandTotal / peopleCount
        
        
        return amountPerPerson
    }
  
    let tipPercentages = [0, 10, 15, 20, 25]
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Bill Amount", value: $billAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($billAmountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 15) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0 ..< 101) {
                            Text($0, format: .percent)
                        }
                    } .pickerStyle(.wheel)
                } header: {
                    Text("How Much Tips Percentage?")
                }
                
                Section {
                    Text("Original Bill Amount: \(billAmount, specifier: "%.2f")")
                    Text("Tax Amount: \(billAmount * Double(tipPercentage) / 100, specifier: "%.2f")")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        billAmountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}
