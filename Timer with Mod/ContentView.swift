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
    
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common) .autoconnect ()
    
    
    
    var body: some View {
        
        VStack {
            Button("1 Minute")
            {   countDownTimerSeconds = 0
                countDownTimerMinutes = 1
                totalSeconds = (countDownTimerMinutes * 60)
                textSeconds = "0 Seconds"
                textMinutes = "1 Minute"

                
            }
            .frame(width: 100, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(25)
            .padding(.top, 50.0)
            
            Button("15 Minute")
            {   countDownTimerSeconds = 0
                countDownTimerMinutes = 15
                totalSeconds = (countDownTimerMinutes * 60)
                textSeconds = "0 Seconds"
                textMinutes = "15 Minutes"
            }
            .frame(width: 100, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(25)
            Button("30 Minutes")
            {   countDownTimerSeconds = 0
                countDownTimerMinutes = 30
                totalSeconds = (countDownTimerMinutes * 60)
                textSeconds = "0 Seconds"
                textMinutes = "30 Minutes"
            }
            .frame(width: 100, height: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(25)
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
            Button("Start") {
                timerRunning = true
            }
            .frame(width: 150, height: 50 )
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(25)
            Button("Stop") {
                timerRunning = false
            }
            .frame(width: 150, height: 50 )
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(25)
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
