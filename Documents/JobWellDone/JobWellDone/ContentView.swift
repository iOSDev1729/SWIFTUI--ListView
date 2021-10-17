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
        HStack {
            VStack {
        Color.orange
            .padding(.all)
        
        Text("Radhika").padding()
        Image("balatripurasundari")
        
        List(myArray, id: \.self) {Text($0)}
        
                List {
                    Image(systemName: "list.dash")
                    Text("Second")
                    Button(action: {
                        print("Action")
                    }) {
                        Text("Button")
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

/*extension ContentView {
    class ViewModel:ObservedObject {
        @Published var users = [User]()
        
}
}*/
    }
}

//MARK:

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
            
    }
}

    
