//
//  ContentView.swift
//  Sorting-Visualized
//
//  Created by Marshall Lee on 2020-04-20.
//  Copyright © 2020 Marshall Lee. All rights reserved.
//

import SwiftUI

let BarWidth: CGFloat = 10
let BarMaxHeight: CGFloat = 200
let BarUnit: CGFloat = 10

struct ContentView: View {
    @State var pickerSelected = 0
    @State var barList: [Bar] = _initializeBarList().shuffled()
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0, green: 1, blue: 0.895160675, alpha: 1)).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Sortings, Visualized")
                .font(.system(size: 32))
                .foregroundColor(Color.black)
                .fontWeight(.heavy)
                
                Picker(selection: $pickerSelected, label: Text("")) {
                    Text("Bubble").tag(0)
                    Text("Selection").tag(1)
                    Text("Quick").tag(2)
                    Text("Merge").tag(3)
                    Text("Cocktail").tag(4)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                
                HStack(spacing: 5) {
                    ForEach(self.barList, id: \.self) { bar in
                        bar
                    }
                }.padding(.top, 28).padding(.bottom, 28)
                .animation(.default)
                    
                
                HStack(spacing: 30) {
                    Button(action: {
                        self._startSorting()
                    }) {
                        Text("Start")
                            .fontWeight(.heavy)
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                    }
                    
                    Button(action: {
                        self._shuffleList()
                    }) {
                        Text("Shuffle")
                            .fontWeight(.heavy)
                            .font(.system(size: 30))
                            .foregroundColor(Color.black)
                    }
                }
            }
        }
    }
    
    
    //====================== BUTTONS ACTIONS =====================
    // This performs sorting algorithms, and adjust bar's value to be rendered
    public func _startSorting() -> Void {
        switch pickerSelected {
            case 0: _bubbleSort()
            case 1: _bubbleSort()
            case 2: _bubbleSort()
            case 3: _bubbleSort()
            case 4: _bubbleSort()
            default:
                print("invalid picker input!")
                self._shuffleList()
        }
    }
    
    // This randomizes the bar arrays
    private func _shuffleList() -> Void {
        self.barList = _initializeBarList().shuffled()
    }
    //============================================================
    
    
    //========================= SORTINGS =========================
    // perform bubble sort
    public func _bubbleSort() -> Void{
        let length: Int = self.barList.count
        for i in 0..<length - 1 {
            for j in 0..<length - i - 1 {
                if barList[j].value > barList[j + 1].value {
                    DispatchQueue.main.async {
                        self._swap(this: j, that: j + 1);
                        print("swap")
                    }
                    DispatchQueue.global(qos: .userInteractive).async {
                        print("sleep")
                    }
                }
            }
        }
    }
    
    // perform selection sort
    public func _selectionSort() -> Void {
        //
    }
    
    // perform quick sort
    public func _quickSort() -> Void {
        //
    }
    
    // perform merge sort
    public func _mergeSort() -> Void {
        //
    }
    
    // perform cocktail sort
    public func _cocktailSort() -> Void {
        //
    }
    //============================================================
    
    
    //========================== UTILS ===========================
    
    func _swap(this: Int, that: Int) -> Void {
        let temp = self.barList[this]
        self.barList[this] = self.barList[that]
        self.barList[that] = temp
    }
    
    //============================================================

}


//========================= INIT =========================
/*
 This returns bars list to be rendered based on the screen width
 */
private func _initializeBarList() -> [Bar] {
    var out: [Bar] = []
    // starting from 1 to multiply
    for n in 1...Int((UIScreen.main.bounds.width - 10) / (BarWidth + 10)) {
        let input: CGFloat = (CGFloat(n) * BarUnit)
        out.append(Bar(value: input))
        if input >= BarMaxHeight { // shouldn't exceed the max height. stop adding
            break
        }
    }
    return out
}
//========================================================



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
