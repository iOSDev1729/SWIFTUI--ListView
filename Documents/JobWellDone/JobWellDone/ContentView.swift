//
//  ContentView.swift
//  JobWellDone
//
//  Created by Radhika Chilukuri on 15/10/21.
//

import SwiftUI

struct ContentView: View {
   
    @State var myArray = ["ghg","yhty","hdty","hrhr","rtbb","rtyert"]
    
    
    var body: some View {
        Color.green
       
        List(myArray, id: \.self) {Text($0)}
        
        List {
            Image(systemName: "list.dash")
            Text("Second")
            Button(action: {
                    print("Action")
            }) {
                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
            }
            ForEach(1..<50) { index in
                Text("\(index)")
            }
        }
        .font(.headline)
        .clipped()
       
            }
    
       // Text("Hello, world!")
           // .padding()
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

