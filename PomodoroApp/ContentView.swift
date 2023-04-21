//
//  ContentView.swift
//  Pomodoro2
//
//  Created by Райымбек Есетов on 05.04.2023.
//

import SwiftUI


struct ContentView: View {
    
    @State var changeBackground = true
    @State var studyBackground = false
    @State var workoutBackground = false
    @State var readingBackground = false
    @State var meditationBackground = false
    @State var othersBackground = false
    @State private var shouldShowDetail: Bool = false
    @State private var shouldShowDetailMain: Bool = false
    @State private var numOfPeople = "25:00"
    @State var counter: Int = 0
    @State var countTo: Int = 1500
    @State var breakTime: Int = 300
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var start = false
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

    
    let items = ["Focus Time", "Break time  "]
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    ZStack {
                        if changeBackground == true {
                            Image("BG")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        if studyBackground == true {
                            Image("BG2")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        if workoutBackground == true {
                            Image("BG3")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        if readingBackground == true {
                            Image("BG4")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        if meditationBackground == true {
                            Image("BG5")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        if othersBackground == true {
                            Image("BG6")
                                .resizable()
                                .ignoresSafeArea()
                        }
                        VStack {
                            
                            //focusCategory
                            Button(action: {
                                shouldShowDetail = true
                                
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color.white)
                                        .frame(width: 170, height: 36)
                                        .opacity(0.5)
                                    HStack {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                        Text("Focus Category")
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                            .sheet(isPresented: $shouldShowDetail) {
                                sheetView(shouldShowDetail: $shouldShowDetail, changeBackground: $changeBackground, studyBackground: $studyBackground, workoutBackground: $workoutBackground, readingBackground: $readingBackground, meditationBackground: $meditationBackground, othersBackground: $othersBackground)
                                    .presentationDetents([.height(340)])
                                    .presentationCornerRadius(20)
                            }
                            .padding(.top, 80)
                            
                            
                            //circle
                            ZStack {
                                //track circle
                                Circle()
                                    .stroke(Color.white.opacity(0.4), style: StrokeStyle(lineWidth: 8))
                                //animate circle
                                Circle()
                                    .trim(from: 0, to: progress())
                                    .stroke(Color.white, style: StrokeStyle(lineWidth: 8))
                                    .rotationEffect(.init(degrees: -90))
                                VStack {
                                    Group {
                                        clock(counter: counter, countTo: countTo)
//                                        timer.upstream.connect().cancel()
                                    }
                                    Text("Focus on your task")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .regular, design: .default))
                                }
                            }
                            .onReceive(timer) { time in
                                if (self.counter < self.countTo) {
                                    self.counter += 1
                                }
                            }
                            .padding(50)
                            
                            //buttonsPlay&Stop
                            HStack {
                                Button(action: {
                                    if start == false {
                                        timer.upstream.connect().cancel()
                                    } else {
                                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                                    }
                                    self.start.toggle()

                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white.opacity(0.4))
                                            .frame(width: 56)
                                            .padding(.leading, 40)
                                        Image(systemName: start ? "play" : "pause.fill")
                                            .padding(.leading, 38)
                                            .foregroundColor(.white)
                                            .font(.system(size: 25, weight: .heavy))
                                    }
                                }
                                .padding(.trailing, 80)
                                Button(action: {
                                    start = true
                                    counter = 0
                                    timer.upstream.connect().cancel()
                                }) {
                                    ZStack {
                                        Circle()
                                            .fill(Color.white.opacity(0.4))
                                            .frame(width: 56)
                                            .padding(.trailing, 40)
                                        Image(systemName: "stop.fill")
                                            .padding(.trailing, 38)
                                            .foregroundColor(.white)
                                            .font(.system(size: 25, weight: .heavy))
                                    }
                                }
                            }
                            
                            
                            Spacer()
                            
                        }
                    }
                    
                    //tabView
                    .tabItem {
                        
                        Label("Main", systemImage: "house")
                    }
                    .foregroundColor(.black)
                    
                    //tabView Settings - start
                    settingsView(countTo: $countTo, breakTime: $breakTime)
                    .tabItem {
                        Label("Settings", systemImage: "slider.horizontal.3")
                    }
                    
                    //tabView Settings - end
                    
                    ZStack {
                        Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.12, alpha: 1))
                            .ignoresSafeArea()
                            .overlay(
                                VStack {
                                    Text("History")
                                        .font(.system(size: 17, weight: .semibold, design: .default))
                                        .foregroundColor(.white)
                                        .padding(.top, 80)
                                        .padding(.bottom, 30)
                                    Spacer()
                                    List {
                                        Section {
                                            ForEach(items, id: \.self) { item in
                                                HStack {
                                                    Text(item)
                                                        .foregroundColor(.white)
                                                    TextField("Total number of people", text: $numOfPeople)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(.white)
                                                        .padding(.leading, 200)
                                                }
                                            }
                                            .listRowBackground(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)))
                                            
                                        } header: {
                                            Text("21.11.22")
                                                .font(.system(size: 25, weight: .bold, design: .default))
                                                .foregroundColor(.white)
                                                .padding(.bottom, 16)
                                            
                                        }
                                        
                                        Section {
                                            ForEach(items, id: \.self) { item in
                                                HStack {
                                                    Text(item)
                                                        .foregroundColor(.white)
                                                    TextField("Total number of people", text: $numOfPeople)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(.white)
                                                        .padding(.leading, 200)
                                                }
                                            }
                                            .listRowBackground(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)))
                                        } header: {
                                            Text("20.11.22")
                                                .font(.system(size: 25, weight: .bold, design: .default))
                                                .foregroundColor(.white)
                                                .padding(.bottom, 16)
                                        }
                                        
                                        Section {
                                            ForEach(items, id: \.self) { item in
                                                HStack {
                                                    Text(item)
                                                        .foregroundColor(.white)
                                                    TextField("Total number of people", text: $numOfPeople)
                                                        .keyboardType(.numberPad)
                                                        .foregroundColor(.white)
                                                        .padding(.leading, 200)
                                                }
                                            }
                                            .listRowBackground(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)))
                                        } header: {
                                            Text("19.11.22")
                                                .font(.system(size: 25, weight: .bold, design: .default))
                                                .foregroundColor(.white)
                                                .padding(.bottom, 16)
                                        }
                                    }
                                    .listStyle(.plain)
                                })
                    }
                    .edgesIgnoringSafeArea(.all)
                    .tabItem {
                        
                        Label("History", systemImage: "clock")
                    }
                }
                .accentColor(Color.blue)
                
            }
        }
    }
    func completed() -> Bool {
        return progress() == 1
    }
    
    func progress() -> CGFloat {
        return (CGFloat(counter) / CGFloat(countTo))
    }
    
    //settings view
    struct settingsView: View {
        @Binding var countTo: Int
        @Binding var breakTime: Int
        
        var body: some View {
            ZStack {
                Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.12, alpha: 1))
                    .ignoresSafeArea()
                    .overlay(
                        VStack {
                            Text("Settings")
                                .font(.system(size: 17, weight: .semibold, design: .default))
                                .foregroundColor(.white)
                                .padding(.top, 80)
                                .padding(.bottom, 30)
                            Spacer()
                            List {
                                HStack {
                                    Text("Focus Category (sec)")
                                        .foregroundColor(.white)
                                    Spacer()
                                    TextField("0000", value: $countTo, formatter: NumberFormatter())
                                        .frame(width: 46, height: 22)
                                        .keyboardType(.numberPad)
                                        .foregroundColor(.white)
                                }
                                .listRowBackground(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)))
                                
                                HStack {
                                    Text("Break time (sec)")
                                        .foregroundColor(.white)
                                    Spacer()
                                    TextField("0000", value: $breakTime, formatter: NumberFormatter())
                                        .frame(width: 46, height: 22)
                                        .keyboardType(.numberPad)
                                        .foregroundColor(.white)
                                }
                                .listRowBackground(Color(#colorLiteral(red: 0.11, green: 0.11, blue: 0.12, alpha: 1)))
                                
                            }
                            .listStyle(.plain)
                        })
            }
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}



//clock
struct clock: View {
    var counter: Int
    var countTo: Int
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .foregroundColor(.white)
                .font(.system(size: 44, weight: .bold, design: .default))
        }
    }
    
    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime % 60
        let minutes = Int(currentTime / 60)
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}


//sheetView
struct sheetView: View {
    @State private var isEditing = false
    @Binding var shouldShowDetail: Bool
    @Binding var changeBackground: Bool
    @Binding var studyBackground: Bool
    @Binding var workoutBackground: Bool
    @Binding var readingBackground: Bool
    @Binding var meditationBackground: Bool
    @Binding var othersBackground: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
            
            VStack {
                ZStack {
                    HStack {
                        Text("Focus Category")
                            .padding(.top, 20)
                    }
                    
                    HStack {
                        Button(action: {self.shouldShowDetail = false}) {
                            Spacer()
                            Image(systemName: "xmark")
                                .padding(.top, 26)
                                .padding(.trailing, 22)
                        }
                    }
                }
                Spacer()
                
                
                HStack {
                    Button(action: {self.changeBackground.toggle()
                        self.studyBackground = false
                        self.workoutBackground = false
                        self.readingBackground = false
                        self.meditationBackground = false
                        self.othersBackground = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 172, height: 60)
                                .foregroundColor(changeBackground ? .black.opacity(0.8) : Color(.systemGray5))
                            Text("Work")
                                .foregroundColor(changeBackground ? .white : .black)
                        }
                        
                    }
                    
                    
                    Button(action: {self.studyBackground.toggle()
                        self.changeBackground = false
                        self.workoutBackground = false
                        self.readingBackground = false
                        self.meditationBackground = false
                        self.othersBackground = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 172, height: 60)
                                .foregroundColor(studyBackground ? .black.opacity(0.8) : Color(.systemGray5))
                            Text("Study")
                                .foregroundColor(studyBackground ? .white : .black)
                        }
                    }
                    
                }
                .padding(5)
                
                HStack {
                    Button(action: {self.workoutBackground.toggle()
                        self.changeBackground = false
                        self.studyBackground = false
                        self.readingBackground = false
                        self.meditationBackground = false
                        self.othersBackground = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 172, height: 60)
                                .foregroundColor(workoutBackground ? .black.opacity(0.8) : Color(.systemGray5))
                            Text("Workout")
                                .foregroundColor(workoutBackground ? .white : .black)
                        }
                    }
                    
                    Button(action: {self.readingBackground.toggle()
                        self.changeBackground = false
                        self.studyBackground = false
                        self.workoutBackground = false
                        self.meditationBackground = false
                        self.othersBackground = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 172, height: 60)
                                .foregroundColor(readingBackground ? .black.opacity(0.8) : Color(.systemGray5))
                            Text("Reading")
                                .foregroundColor(readingBackground ? .white : .black)
                        }
                    }
                }
                .padding(5)
                
                HStack {
                    Button(action: {self.meditationBackground.toggle()
                        self.changeBackground = false
                        self.studyBackground = false
                        self.workoutBackground = false
                        self.readingBackground = false
                        self.othersBackground = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 172, height: 60)
                                .foregroundColor(meditationBackground ? .black.opacity(0.8) : Color(.systemGray5))
                            Text("Meditation")
                                .foregroundColor(meditationBackground ? .white : .black)
                        }
                    }
                    
                    Button(action: {self.othersBackground.toggle()
                        self.changeBackground = false
                        self.studyBackground = false
                        self.workoutBackground = false
                        self.readingBackground = false
                        self.meditationBackground = false
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .frame(width: 172, height: 60)
                                .foregroundColor(othersBackground ? .black.opacity(0.8) : Color(.systemGray5))
                            Text("Others")
                                .foregroundColor(othersBackground ? .white : .black)
                        }
                    }
                }
                .padding(5)
                
                
                Spacer()
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
    }
}
