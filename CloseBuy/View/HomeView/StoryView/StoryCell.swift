//
//  StoryCell.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 23/06/2021.
//

import SwiftUI

struct StoryCell: View {
    
    let SYSTEM_ORANGE: Color = Color(red: 255/255, green: 116/255, blue: 101/255)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ZStack {
                
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.white)
                    .background(Color.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .cornerRadius(15)
                
                Image("coffee")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(5)
                
                RoundedRectangle(cornerRadius: 15)
                    .stroke(SYSTEM_ORANGE, lineWidth: 3)
                    .frame(minWidth: 0, maxWidth: .infinity)
            }
            .frame(width: 90, height: 110)
            
            ZStack {
            
            Image("coffee")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(minWidth: 0, maxWidth: .infinity)
                Circle()
                    .stroke(Color.white, lineWidth: 3)
                    .frame(minWidth: 0, maxWidth: .infinity)
                
            }
            .frame(width: 40, height: 40)
            .offset(x: 2, y: 2)
        }
    }
}

struct StoryCell_Previews: PreviewProvider {
    static var previews: some View {
        StoryCell()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
