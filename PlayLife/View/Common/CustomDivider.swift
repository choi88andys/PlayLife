//
//  SwiftUIView.swift
//  PlayLife
//
//  Created by MacAndys on 2022/02/23.
//

import SwiftUI



struct CustomDivider: View {
    var percentage: Double = 0.8
    var color: Color = Color.gray
    
    var body: some View {
        Divider()
            .background(color)
            .frame(width: UIScreen.main.bounds.size.width * percentage)
    }
}


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CustomDivider()
    }
}
