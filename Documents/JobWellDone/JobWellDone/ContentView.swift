//
//  ContentView.swift
//  JobWellDone
//
//  Created by Radhika Chilukuri on 15/10/21.
//

import SwiftUI

struct ContentView: View {
   
    @State var myArray = ["ghg","yhty","hdty","hrhr","rtbb","rtyert"]
    //@State var viewModel = ViewModel() // class object or reference or instance
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue,Color.white]), startPoint: /*@START_MENU_TOKEN@*/.topLeading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottomTrailing/*@END_MENU_TOKEN@*/).ignoresSafeArea()
            
            VStack {
               
                Text("IndianWeather").foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(width: 350, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
                    
                    HStack {
                        VStack {
                        Text("Tue").padding()
                            .foregroundColor(.white)
                        
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("45°")
                            .font(.system(size: 40, weight: .light))
                            .foregroundColor(.white).padding()
                        
                    }
                        VStack {
                            Text("Tue").padding()
                                .foregroundColor(.white)
                            
                            Image(systemName: "sun.max.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("45°")
                                .font(.system(size: 40, weight: .light))
                                .foregroundColor(.white).padding()
                        }
                        VStack {
                            Text("Tue").padding()
                                .foregroundColor(.white)
                            
                            Image(systemName: "sun.max.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("45°")
                                .font(.system(size: 40, weight: .light))
                                .foregroundColor(.white).padding()
                        }
                        VStack {
                            Text("Tue").padding()
                                .foregroundColor(.white)
                            
                            Image(systemName: "sun.max.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                            Text("45°")
                                .font(.system(size: 40, weight: .light))
                                .foregroundColor(.white).padding()
                        }
                        
                }
                    
                Spacer()
                   }
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

    
