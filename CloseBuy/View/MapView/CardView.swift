//
//  CardView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 22/06/2021.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var mapViewModel: MapViewModel
    
    let card: Post
    
    @State var x: CGFloat = 0.0
    @State var y: CGFloat = 0.0
    @State var degrees: Double = 0.0
    
    private func dropFirst(){
        withAnimation {
            mapViewModel.dropFirst()
        }
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)){
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
                Image(card.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxHeight: .infinity)
                    .clipped()
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(card.title.uppercased())
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.leading)
                }
                .foregroundColor(.white)
                .padding(30)
            }
            
            ZStack {
                Image(systemName: "checkmark.circle")
                    .opacity(Double(x))
                Image(systemName: "x.circle")
                    .opacity(Double(x * -1))
            }
            .font(.system(size: 100, weight: .bold))
            .foregroundColor(.white)
            
        }
        .cornerRadius(25)
        
        .offset(x: x, y: y)
        .rotationEffect(.init(degrees: degrees))
        .animation(.interpolatingSpring(stiffness: 165, damping: 165))
        
        .gesture(
            DragGesture()
                .onChanged({ value in
                    x = value.translation.width
                    y = value.translation.height
                    degrees = 7 * (value.translation.width) > 0 ? 1 : -1
                })
                .onEnded{ value in
                    switch value.translation.width {
                    case 0...100:
                        x = 0; y = 0; degrees = 0
                    case x where x > 100:
                        x = 500; degrees = 12
                        self.dropFirst()
                    case (-100)...(-1):
                        x = 0; y = 0; degrees = 0
                    case x where x < -100:
                        x = -500; degrees = -12
                        self.dropFirst()
                    default: x = 0; y = 0;
                    }
                }
        )
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { proxy in
            CardView(card: Post.data[0])
                .padding()
        }
    }
}
