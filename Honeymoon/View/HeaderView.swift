//
//  HeaderView.swift
//  Honeymoon
//
//  Created by Jasmine Lai Hweeying on 14/06/2023.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var showInfoView: Bool
    @Binding var showGuideView: Bool
    let haptics = UINotificationFeedbackGenerator()
    
    var body: some View {
        HStack{
            Button(action: {
              // ACTION
              playSound(sound: "sound-click", type: "mp3")
              haptics.notificationOccurred(.success)
              showInfoView.toggle()
            }) {
              Image(systemName: "info.circle")
                .font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
            
            Spacer()
            
            Image("logo-honeymoon-pink")
              .resizable()
              .scaledToFit()
              .frame(height: 28)
            
            Spacer()
            
            Button(action: {
              // ACTION
              playSound(sound: "sound-click", type: "mp3")
              haptics.notificationOccurred(.success)
              showGuideView.toggle()
            }) {
              Image(systemName: "questionmark.circle")
                .font(.system(size: 24, weight: .regular))
            }
            .accentColor(Color.primary)
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    @State static var showGuide: Bool = false
    @State static var showInfo: Bool = false
    
    static var previews: some View {
        HeaderView(showInfoView: $showInfo, showGuideView: $showGuide)
        .previewLayout(.fixed(width: 375, height: 80))
    }
}
