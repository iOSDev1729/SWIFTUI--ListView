//
//  ContentView.swift
//  JobWellDone
//
//  Created by Radhika Chilukuri on 15/10/21.
//

import SwiftUI

struct ContentView: View {
   var body: some View {
    
        ZStack {         // Background view fill out entire screen
            LinearGradient(gradient: Gradient(colors: [Color.blue,Color.white]), startPoint: /*@START_MENU_TOKEN@*/.topLeading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottomTrailing/*@END_MENU_TOKEN@*/).ignoresSafeArea()
            
//MARK: //On top of ZStack, all UIView elements will be arranged vertically along with the specified frame contraints
            
        VStack {
               
                Text("IndianWeather").foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(width: 350, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    //MARK: frame constraints
                    .padding()
                
        VStack {
                    Image(systemName: "cloud.sun.fill")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 180, height: 150)
                    
                    
                    Text("76°")
                        .font(.system(size: 65, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
        }
            Spacer()
            
 //MARK: UIView will be arranged (embedded) horizontally on top of vertical stack
        
            HStack(spacing:7) {
                WeatherDayView(dayOfWeek: "TUE",
                                imageName: "cloud.bolt.rain.fill",
                                temperature: 77)
                WeatherDayView(dayOfWeek: "WED",
                                imageName: "cloud.moon",
                                temperature: 45)
                WeatherDayView(dayOfWeek: "THU",
                                imageName: "wind.snow",
                                temperature: 23)
                WeatherDayView(dayOfWeek: "FRI",
                               imageName: "thermometer.sun",
                               temperature: 78)
                WeatherDayView(dayOfWeek: "SAT",
                               imageName: "sun.dust.fill",
                               temperature: 67)
                
    }
            Spacer()
            
            Text("Change Date And Time")
                    
    Spacer()
    }
            }
        
            
    }
            }



//MARK:

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
}
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek)
                .padding()
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height:40)
            Text("\(temperature)")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.blue)
                .padding()
        }
    }
}
