//
//  ContentView.swift
//  Timer App
//
//  Created by Dharsini S on 07/05/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerViewModel : TimerViewModel
    @State var isPlaying : Bool = false
    @State var displayTime : String = "00:00:00"
    init(seconds: TimeInterval = 0 ) {
        self.timerViewModel = TimerViewModel(seconds: seconds, goalTime: 20)
    }
    var body: some View {
        VStack {
            
            ZStack{
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 10,dash: [2,6]))
                    .frame(width: 300,height: 400)
                
                Text("\(timerViewModel.displayTime)").font(.largeTitle)
                    .fontWeight(.heavy)
                
                progressCircle
            }
            
            HStack {
                if isPlaying {
                    Button(action: {
                        timerViewModel.stopSession()
                    }){
                        
                        HStack{
                            Image(systemName: "pause.fill")
                            Text("Pause")
                        }
                        
                    }.padding()
                        .buttonStyle(.borderedProminent)
                }else{
                    Button(action: {
                        timerViewModel.startTimer()
                    }){
                        
                        HStack{
                            Image(systemName: "play.fill")
                            Text("Start")
                        }
                        
                    }.padding()
                        .buttonStyle(.borderedProminent)
                }
               
                
                Button(action: {
                    timerViewModel.reset()
                }){
                    HStack{
                        Image(systemName: "arrow.trianglehead.clockwise")
                        Text("Reset")
                    }
                }.padding()
                    .buttonStyle(.borderedProminent)
            }
            
            
        }
        .onAppear{
            timerViewModel.startTimer()
        }
        .padding()
    }
    
    private var progressCircle : some View {
       
            Circle()
            .trim(from: 0,to: timerViewModel.progress/timerViewModel.goalTime)
            .stroke(Color.red, style: StrokeStyle(lineWidth: 10,lineCap: .butt,dash: [2,6]))
            .rotationEffect(Angle(degrees: -90))
            .animation(.spring, value: timerViewModel.progress)
            
        
       
        
    }
}

#Preview {
    ContentView()
}
