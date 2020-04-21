import SwiftUI
import Foundation

struct Bar: View, Hashable {
    var value: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Capsule().frame(width: BarWidth, height: BarMaxHeight)
                .foregroundColor(Color(#colorLiteral(red: 0, green: 0.8890399337, blue: 0.7886388898, alpha: 1)))
            Capsule().frame(width: BarWidth, height: value)
                .foregroundColor(Color.white)
        }.padding(.top, 40)
    }
}
