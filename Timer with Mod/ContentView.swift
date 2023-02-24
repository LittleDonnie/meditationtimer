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
    @State  var meditationTime = "0:00"
    @State  var meditationTimeInt = 0
    
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common) .autoconnect ()
    
    
    
    var body: some View {
        ZStack{
        LinearGradient(
            colors: [.yellow, .red],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).ignoresSafeArea()
        
            VStack {
                Text("Select Minutes to Meditate")
                    .font(.title2)
                    .padding(.top, 40.0)
                HStack{
                    Button("15")
                    {
                        setTimerMinutesSeconds(minutes: 15, seconds: 0)
                    }
                    .font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.trailing, 10.0)
                    Button("30")
                    {
                        setTimerMinutesSeconds(minutes: 30, seconds: 0)
                    }.font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.leading, 10.0)
                }
                HStack{
                    Button("45")
                    {
                        setTimerMinutesSeconds(minutes: 45, seconds: 0)
                    }.font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.trailing, 10.0)
                    
                    Button("60")
                    {
                        setTimerMinutesSeconds(minutes: 60, seconds: 0)
                    }.font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
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
                                meditationTimeInt += 1
                            
                            //caculate meditationTime (text) here
                            
                            meditationTime =   String (meditationTimeInt / 60) + ":"
                            
                            if ( (meditationTimeInt % 60) <= 9) {
                                meditationTime = (meditationTime + "0" + String (meditationTimeInt % 60))
                                }
                            else { meditationTime = meditationTime + String (meditationTimeInt % 60)
                                
                            }
                            
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
                Text("Meditation Time: " + meditationTime)
                    .font(.title2)
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
                        .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                        .opacity(0.8)
                        .foregroundColor(.white)
                        .cornerRadius(25)

                    Button("Stop") {
                        timerRunning = false
                        countDownTimerSeconds = 0
                        countDownTimerMinutes = 0
                        meditationTimeInt = 0
                        textMinutes = "0 Minutes"
                        textSeconds = "0 Seconds"
                        leftButtonText = "Start"
                    }
                    .font(.title)
                    .frame(width: 150, height: 100 )
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }.padding(.bottom, 50.0)

            
            }
            
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
