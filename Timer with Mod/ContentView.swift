//
//  ContentView.swift
//  Timer with Mod
//
//  Created by Donald Montgomery on 2/14/23.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State  var countDownTimerSeconds = 0
    @State  var countDownTimerMinutes = 0
    @State  var timerRunning = false
    @State  var totalSeconds = 0
    @State  var textMinutes = "0 Minutes"
    @State  var textSeconds = "0 Seconds"
    @State  var leftButtonText = "Start"
    @State  var meditationTime = "0:00" //this is the time one has meditated. counting up from zero
    @State  var meditationTimeInt = 0
    @State  var selectedIndex = "2 Intervals"
    
    private let numberOfIntervals = [
        "1 Interval",
        "2 Intervals",
        "3 Intervals",
        "4 Intervals"
    ]
    @State var selectedInterval: String = "1 Interval"
    @State var divisionTime = 1

    let timer = Timer.publish(every: 1, on: .main, in: .common) .autoconnect ()
    
    
    
    var body: some View {
        ZStack{
            LinearGradient(
                colors: [.yellow, .red],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
            
            VStack {
                // MARK: Select Minutes
                
                Text("Select Minutes to Meditate")
                    .font(.title2)
                    .padding(.top, 40.0)
                    .padding(.bottom, 20.0)
                HStack{
                    Button("15"){
                        // setTimerMinutesSeconds(minutes: 15, seconds: 0)
                        setTimerMinutesSeconds(minutes: 0, seconds: 20)
                    }
                    .font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.trailing, 10.0)
                    Button("30"){
                        setTimerMinutesSeconds(minutes: 30, seconds: 0)
                    }
                    .font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.leading, 10.0)
                }
                HStack{
                    Button("45"){
                        setTimerMinutesSeconds(minutes: 45, seconds: 0)
                    }
                    .font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.trailing, 10.0)
                    
                    Button("60"){
                        setTimerMinutesSeconds(minutes: 60, seconds: 0)
                    }
                    .font(.title2)
                    .frame(width: 100, height: 50)
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.leading, 10.0)
                }
                
                
                // MARK: Picker (Interval)
                
                Picker ("Choose an Interval", selection: $selectedInterval) {
                    ForEach (numberOfIntervals, id: \.self) { intervals in
                        Text (intervals)}
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding([.top, .leading, .trailing], 20.0)
                Spacer()
                Text (textMinutes)
                    .font(.largeTitle)
                Text (textSeconds)
                    .font(.largeTitle)
                Spacer()
                Text("Meditation Time: " + meditationTime)
                    .font(.title2)
                
                // MARK: Start-Stop
                HStack{
                    Button(leftButtonText) {
                        if(leftButtonText == "Start"){
                            playSound(sound: "oneChime", type: "mp3")
                            divisionTime = getTimePerDivision()
                        }
                        
                        if (timerRunning == false){
                            timerRunning = true
                            leftButtonText = "Pause"
                            
                        }
                        else{
                            timerRunning = false
                            leftButtonText = "Resume"
                        }
                    }
                    .font(.title)
                    .frame(width: 150, height: 100 )
                    .background(Color(hue: 0.641, saturation: 0.496, brightness: 0.599))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    
                    Button("Stop") {
                        
                        playSound(sound: "oneChime", type: "mp3")
                        timerRunning = false
                        meditationTimeInt = 0
                        meditationTime = "0:00"
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
                
                
                    .onReceive(timer) { _ in
                        if meditationTimeInt == 0 && timerRunning {
                            divisionTime = getTimePerDivision()
                            textSeconds = "0 Seconds"
                        }
                        
                        if totalSeconds > 0 && timerRunning {
                            meditationTimeInt += 1
                            
                            if  (meditationTimeInt == divisionTime )    ||
                                (meditationTimeInt == divisionTime * 2) ||
                                (meditationTimeInt == divisionTime * 3)

                            {
                                playSound(sound: "oneChime", type: "mp3")
                            }
                            
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
                            if leftButtonText == "Pause"
                            {
                                // set end of meditation
                                textSeconds = "0 Seconds"
                                timerRunning = false
                                playSound(sound: "oneChime", type: "mp3")
                                leftButtonText = "Start"
                            }
                            
                        }
                        
                    }
            }
        }
    }
    
    
    func getTimePerDivision() -> Int {
        switch selectedInterval {
            case "1 Interval" :
                divisionTime = totalSeconds + 1
            case "2 Intervals" :
                return(totalSeconds / 2)
            case "3 Intervals" :
                return(totalSeconds / 3)
            case "4 Intervals" :
                return(totalSeconds / 4)
                
            default :
                return (1000)
        }
        return (1000)
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
