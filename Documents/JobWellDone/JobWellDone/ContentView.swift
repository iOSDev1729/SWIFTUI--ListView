//
//  ContentView.swift
//  JobWellDone
//
//  Created by Radhika Chilukuri on 15/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNight = false
    
   var body: some View {
    //MARK: Background view fill out entire screen
    ZStack {
        //BackgroundView(topColor: isNight ? .black : .blue,bottomColor: isNight ? .gray : Color("LightBlue1"))
        BackgroundView(isNight: $isNight)
        //Binding Variable. Please refer BackgroundView structure code below
            
//MARK: //On top of ZStack, all UIView elements will be arranged vertically along with the specified frame contraints
            
            VStack {
               
                CityTextView(cityName: "Indian Weather,IN")
                
                CityImageAndTemperatureView(
                    imageName: "wind.snow",
                    cityTemperature: 76)
            
 //MARK: UIView will be arranged (embedded) horizontally on top of vertical stack
        
            HStack(spacing:7) {
 //MARK: All WeatherDayViews are in VStack. Refer below extracted subview code
                WeatherDayView(dayOfWeek: "TUE",
                                imageName:"cloud.bolt.rain.fill",
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
            .padding(.bottom,70)
                
                Button {
                    print("tapped")
                    isNight.toggle()
                }label:{
                ButtonView(titile: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                    
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
                .foregroundColor(.white)
                .padding()
        }
    }
}

struct BackgroundView: View {
    //var topColor: Color
//    var bottomColor: Color
    @Binding var isNight: Bool
    var body: some View {
       /* LinearGradient(gradient: Gradient(colors:  [topColor,bottomColor]),
              startPoint : /*@START_MENU_TOKEN@*/.topLeading/*@END_MENU_TOKEN@*/,
              endPoint: /*@START_MENU_TOKEN@*/.bottomTrailing/*@END_MENU_TOKEN@*/)
              .ignoresSafeArea()*/
        LinearGradient(gradient: Gradient(colors:  [isNight ? .black : .blue ,isNight ? .gray : Color("lightBlue")]),
               startPoint : /*@START_MENU_TOKEN@*/.topLeading/*@END_MENU_TOKEN@*/,
               endPoint: /*@START_MENU_TOKEN@*/.bottomTrailing/*@END_MENU_TOKEN@*/)
               .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .foregroundColor(.white)
            .font(.largeTitle)
            .frame(width: 300, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            //MARK: frame constraints
            .padding()
    }
}


struct CityImageAndTemperatureView: View {
    var imageName: String
    var cityTemperature: Int
    var body: some View {
        VStack(spacing:20) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .frame(width: 180, height: 160)
            
            
            Text("\(cityTemperature)")
                .font(.system(size: 65, weight: .medium))
                .foregroundColor(.white)
                .frame(width: 150, height: 50)
        }
        .padding(.bottom,40)
    }
}
