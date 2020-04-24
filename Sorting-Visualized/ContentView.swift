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
let BarColor_Default: Color = .white
let BarColr_Selected: Color = .purple

var timer: Timer?
var generalCounter: Int = 0

enum Sorting {
    case bubble, selection, quick, merge, cocktail
    
    var sortingSpeed: TimeInterval {
        switch self {
        case .bubble:       return 0.4
        case .selection:   return 1.2
        case .quick:        return 0.5
        case .merge:        return 0.5
        case .cocktail:     return 0.5
        }
    }
}

struct ContentView: View {
    @State var isRunning = false
    @State var isPaused = false
    @State var pickerSelected = 0
    @State var barList: [Bar] = _initializeBarList().shuffled()
    @State var backLog: [Bar]?
    
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
                    .disabled(self.isRunning)
                
                HStack(spacing: 5) {
                    ForEach(self.barList, id: \.self) { bar in
                        bar
                    }
                }.padding(.top, 28).padding(.bottom, 28)
                .animation(.default)
                    
                
                HStack(spacing: 30) {
                    Button(action: {
                        if !self.isRunning {
                            self._startSorting()
                        } else if self.isRunning && !self.isPaused{
                            self._pauseResume()
                        } else if self.isRunning && self.isPaused {
                            self.isPaused = false
                            self._startSorting()
                        }
                    }) {
                        if !self.isRunning {
                            Text("START")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        } else if self.isRunning && !self.isPaused {
                            Text("PAUSE")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        } else if self.isRunning && self.isPaused {
                            Text("RESUME")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                    }
                    
                    Button(action: {
                        // list shoudn't be shuffled while soring
                        if !self.isRunning {
                            self._shuffleList()
                        } else if self.isRunning {
                            timer?.invalidate()
                            self.isRunning = false
                            self.isPaused = false
                            self.barList = self.backLog ?? _initializeBarList()
                            self.backLog = nil
                        }
                    }) {
                        if !isRunning {
                            Text("SHUFFLE")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(!isRunning ? Color.black: Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)))
                        } else if isRunning {
                            // reset button should always be available
                            // this stop any activity, and reload the bar list
                            Text("RESET")
                                .fontWeight(.heavy)
                                .font(.system(size: 30))
                                .foregroundColor(Color.black)
                        }
                    }
                }
            }
        }
    }
    
    
    //====================== BUTTONS ACTIONS =====================
    // This performs sorting algorithms, and adjust bar's value to be rendered
    public func _startSorting() -> Void {
        if backLog == nil {
            self.backLog = self.barList
        }
        switch pickerSelected {
        case 0: _performSorting(kind: .bubble)
        case 1: _performSorting(kind: .selection)
        case 2: _performSorting(kind: .quick)
        case 3: _performSorting(kind: .merge)
        case 4: _performSorting(kind: .cocktail)
            default:
                print("invalid picker input!")
                self._shuffleList()
        }
    }
    
    // This randomizes the bar arrays
    private func _shuffleList() -> Void {
        self.barList = _initializeBarList().shuffled()
    }
    
    private func _pauseResume() {
        timer?.invalidate()
        self.isPaused = true
    }
    //============================================================
    
    
    //========================= SORTINGS =========================
    public func _performSorting(kind: Sorting) {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: kind.sortingSpeed, repeats: true) { timer in
            // i think initializing timer everytime would be worse than a repetitive switch case
            // kind wouldn't change within a single _performSorting invocation
            switch kind {
            case .bubble: self._bubbleSort()
            case .selection: self._selectionSort()
            case .quick: self._quickSort()
            case .merge: self._mergeSort()
            case .cocktail: self._cocktailSort()
            }
        }
    }
    
    // perform bubble sort
    public func _bubbleSort() -> Void {
        let length: Int = self.barList.count
        for i in 0..<length - 1 {
            for j in 0..<length - i - 1 {
                self.barList[j].selected = true
                if self.barList[j].value > self.barList[j + 1].value {
                    self._swap(this: j, that: j + 1);
                    return; // timer loop goes on as long as it's valid
                }
            }
        }
        endOperation()
    }
    
    // perform selection sort
    public func _selectionSort() -> Void {
        let length: Int = self.barList.count
        
        for i in generalCounter..<length - 1 {
            generalCounter += 1
            var minIndex: Int = i
            
            for j in i + 1..<length {
                if barList[j].value < barList[minIndex].value {
                    minIndex = j
                }
            }
            self.barList[i].selected = true
            self.barList[minIndex].selected = true
            self._swap(this: i, that: minIndex)
            return;
        }
        endOperation()
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
    
    // this swaps two bars based on the given indexes
    func _swap(this: Int, that: Int) -> Void {
        let temp = self.barList[this]
        self.barList[this] = self.barList[that]
        self.barList[that] = temp
    }
    
    // this ends sorting operation, and reset states
    func endOperation() -> Void {
        timer?.invalidate() // invalidate timer loop
        isRunning = false // update running status once sorting is finished
        isPaused = false
        backLog = nil
        generalCounter = 0
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
        out.append(Bar(value: input, selected: false))
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
