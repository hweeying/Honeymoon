//
//  InfoRowComponent.swift
//  Honeymoon
//
//  Created by Jasmine Lai Hweeying on 15/06/2023.
//

import SwiftUI

struct InfoRowComponent: View {

    var title: String
    var content: String
    var hasDivider: Bool

    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.gray)

                Spacer()

                Text(content)
            }
            
            if hasDivider {
                Divider()
            }
        }
    }
}

struct InfoRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        InfoRowComponent(title: "Title", content: "content", hasDivider: true)
            .previewLayout(.sizeThatFits)
    }
}
