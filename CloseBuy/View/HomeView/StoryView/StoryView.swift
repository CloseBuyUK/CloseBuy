//
//  StoryView.swift
//  CloseBuy
//
//  Created by Connor A Lynch on 23/06/2021.
//

import SwiftUI

struct StoryView: View {
    var body: some View {
        LazyHStack(spacing: 10) {
            ForEach(1...5, id: \.self){ story in
                StoryCell()
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
