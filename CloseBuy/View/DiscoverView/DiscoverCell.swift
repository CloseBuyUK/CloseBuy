//
//  DiscoverCell.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 30/06/2021.
//

import SwiftUI

struct DiscoverCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                Image("coffee")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                    .clipped()
                
                ZStack {
                
                Image("coffee")
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .clipShape(Circle())
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                }
                .frame(width: 50, height: 50)
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Discount text goes here")
                    .font(.system(size: 22, weight: .semibold))
            }
            .padding(8)
        }//MARK: VStack
        .frame(width: 350)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct DiscoverCell_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCell()
    }
}
