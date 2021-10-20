
import SwiftUI
import Foundation


struct ButtonView: View {
    var titile: String
    var textColor: Color
    var backgroundColor: Color
    var body: some View {
        
            Text(titile)
                .frame(width: 290, height: 50)
                .font(.system(size: 25, weight: .bold, design: .rounded))
                .foregroundColor(textColor)
                .background(backgroundColor)
                .animation(.easeIn)
                .cornerRadius(20)
            
        }
    }



