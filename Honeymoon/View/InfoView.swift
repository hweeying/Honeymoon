//
//  InfoView.swift
//  Honeymoon
//
//  Created by Jasmine Lai Hweeying on 15/06/2023.
//

import SwiftUI

struct InfoView: View {

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 20) {
                HeaderComponent()

                Text("App Info")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(Color.pink)

                VStack {
                    InfoRowComponent(title: "Application", content: "Honeymoon", hasDivider: true)
                    InfoRowComponent(title: "Compatibility", content: "iPhone and iPad", hasDivider: true)
                    InfoRowComponent(title: "Developer", content: "Jasmine", hasDivider: true)
                    InfoRowComponent(title: "Designer", content: "Robert Pestras", hasDivider: true)
                    InfoRowComponent(title: "Website", content: "swiftuimasterclass.com", hasDivider: true)
                    InfoRowComponent(title: "Version", content: "1.0.0", hasDivider: false)
                }

                Text("Credits")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .foregroundColor(Color.pink)

                VStack {
                    InfoRowComponent(title: "Photos", content: "Unsplash", hasDivider: true)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Photographers")
                            .foregroundColor(.gray)
                        Text("Shifaaz Shamoon (Maldives), Grillot Edouard (France), Evan Wise (Greece), Christoph Schulz (United Arab Emirates), Andrew Coelho (USA), Damiano Baschiera (Italy), Daniel Olah (Hungary), Andrzej Rusinowski (Poland), Lucas Miguel (Slovenia), Florencia Potter (Spain), Ian Simmonds (USA), Ian Keefe (Canada), Denys Nevozhai (Thailand), David Köhler (Italy), Andre Benz (USA), Alexandre Chambon (South Korea), Roberto Nickson (Mexico), Ajit Paul Abraham (UK), Jeremy Bishop (USA), Davi Costa (Brazil), Liam Pozz (Australia)")
                            .multilineTextAlignment(.leading)
                            .font(.footnote)
                    }
                }

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Continue".uppercased())
                        .font(.headline)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Capsule().fill(Color.pink))
                        .foregroundColor(Color.white)
                }
            }
        }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(.top, 15)
            .padding(.bottom, 25)
            .padding(.horizontal, 25)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
