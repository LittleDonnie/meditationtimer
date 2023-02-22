//
//  ContentView.swift
//  Timer with Mod
//
//  Created by Donald Montgomery on 2/14/23.
//

import SwiftUI

struct ContentView: View {
    @State  var countDownTimerSeconds = 0
    @State  var countDownTimerMinutes = 0
    @State  var timerRunning = false
    @State  var totalSeconds = 0
    @State  var textMinutes = "0 Minutes"
    @State  var textSeconds = "0 Seconds"
    @State  var leftButtonText = "Start"
    
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common) .autoconnect ()
    
    
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack{
                Button("15 Minute")
                {
                    setTimerMinutesSeconds(minutes: 15, seconds: 0)
                }
                
                .frame(width: 100, height: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(25)
                .padding(.trailing, 10.0)
                Button("30 Minute")
                    {
                    setTimerMinutesSeconds(minutes: 30, seconds: 0)
                    }
                    .frame(width: 100, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.leading, 10.0)
            }
            HStack{
                Button("45 Minutes")
                    {
                    setTimerMinutesSeconds(minutes: 45, seconds: 0)
                    }
                    .frame(width: 100, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.trailing, 10.0)
                    
                Button("60 Minutes")
                    {
                    setTimerMinutesSeconds(minutes: 60, seconds: 0)
                    }
                    .frame(width: 100, height: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.leading, 10.0)
            }
            Spacer()
            Text (textMinutes)
                .font(.largeTitle)
            Text (textSeconds)
                .font(.largeTitle)
            Spacer()
                .onReceive(timer) { _ in
                    if totalSeconds > 0 && timerRunning {
                        // countDownTimerMinutes = (totalSeconds % 60)
                        countDownTimerSeconds = totalSeconds % 60
                        countDownTimerMinutes = (totalSeconds - countDownTimerSeconds) / 60
                        totalSeconds -= 1
                        if countDownTimerMinutes == 1{
                            textMinutes =  String (countDownTimerMinutes) + " Minute"
                        }
                        else {
                            textMinutes =  String (countDownTimerMinutes) + " Minutes"
                        }
                        textSeconds = String (countDownTimerSeconds) + " Seconds"
                        
                    }
                    else {
                        timerRunning = false
                    }
                }
            
            HStack{
                Button(leftButtonText) {
                    if (timerRunning == false){
                        timerRunning = true
                        leftButtonText = "Pause"
                        
                        }
                    else{
                        timerRunning = false
                        leftButtonText = "Resume"
                        
                    }
                }.font(.title)
                .frame(width: 150, height: 100 )
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(25)
                Button("Stop") {
                    timerRunning = false
                    countDownTimerSeconds = 0
                    countDownTimerMinutes = 0
                    textMinutes = "0 Minutes"
                    textSeconds = "0 Seconds"
                    leftButtonText = "Start"
                }
                .font(.title)
                .frame(width: 150, height: 100 )
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(25)
            }
            Spacer()
            }
           
        
    }
    
    func setTimerMinutesSeconds(minutes: Int, seconds: Int ){
        countDownTimerSeconds = seconds
        countDownTimerMinutes = minutes
        totalSeconds = minutes*60 + seconds
        textSeconds = String(seconds) + " Seconds"
        textMinutes = String(minutes) + " Minutes"
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
