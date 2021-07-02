//
//  CustomActionButton.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 18/06/2021.
//

import SwiftUI

struct CustomActionButton: View {
    
    let text: String
    var background: Color = .clear
    var foreground: Color = Color.init(red: 77/255, green: 68/255, blue: 245/255)
    let action: () -> ()
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text(text)
                .font(.custom("Poppins-Bold", size: 18))
                .foregroundColor(foreground)
                .frame(maxWidth: .infinity)
        })
        .padding(17)
        .background(background)
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(foreground, lineWidth: 3)
        )
    }
}

struct CustomActionButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomActionButton(text: "Create Account"){
            print("Howdy")
        }
    }
}
