//
//  CustomTextField.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 18/06/2021.
//

import SwiftUI

struct CustomTextField: View {
    
    let text: String
    @Binding var binding: String
    
    var body: some View {
        TextField(text, text: $binding)
            .font(.system(size: 20))
            .padding()
            .padding(.leading, 10)
            .cornerRadius(25)
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 3)
            )
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(text: "Email", binding: .constant(""))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
