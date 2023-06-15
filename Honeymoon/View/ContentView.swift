//
//  ContentView.swift
//  Honeymoon
//
//  Created by Jasmine Lai Hweeying on 14/06/2023.
//

import SwiftUI

struct ContentView: View {

    @State var showGuide: Bool = false
    @State var showInfo: Bool = false
    @State var showAlert: Bool = false
    @GestureState private var dragState = DragState.inactive
    private var dragAreaThreshold: CGFloat = 65.0
    @State private var lastCardIndex: Int = 1
    @State private var cardRemovalTransition = AnyTransition.trailingBottom

    @State var cardViews: [CardView] = {
        var views = [CardView]()
        for index in 0..<2 {
            views.append(CardView(honeymoon: honeymoonData[index]))
        }
        return views
    }()
    
    private func moveCards(){
        cardViews.removeFirst()
        
        lastCardIndex += 1
        
        let honeymoon = honeymoonData[lastCardIndex % honeymoonData.count]
        
        let newCardView = CardView(honeymoon: honeymoon)
        
        cardViews.append(newCardView)
    }

    private func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }

        return index == 0
    }

    // DRAG STATES
    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)

        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero

            case .dragging(let translation):
                return translation
            }
        }

        var isDragging: Bool {
            switch self {
            case .dragging:
                return true

            case .pressing, .inactive:
                return false
            }
        }

        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true

            case .inactive:
                return false
            }
        }
    }

    var body: some View {
        VStack {
            HeaderView(showInfoView: $showInfo, showGuideView: $showGuide)
                .opacity(dragState.isDragging ? 0 : 1)
                .animation(.default, value: dragState.isDragging)

            Spacer()

            ZStack {
                ForEach(cardViews) { view in
                    view
                        .zIndex(isTopCard(cardView: view) ? 1 : 0)
                        .overlay(
                            ZStack{
                                Image(systemName: "x.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width < -dragAreaThreshold && isTopCard(cardView: view) ? 1 : 0)
                                
                                Image(systemName: "heart.circle")
                                    .modifier(SymbolModifier())
                                    .opacity(dragState.translation.width > dragAreaThreshold && isTopCard(cardView: view) ? 1 : 0)
                            }
                        )
                        .offset(x: isTopCard(cardView: view) ? dragState.translation.width : 0, y: isTopCard(cardView: view) ? dragState.translation.height : 0)
                        .scaleEffect(dragState.isDragging && isTopCard(cardView: view) ? 0.85 : 1)
                        .rotationEffect(Angle(degrees: isTopCard(cardView: view) ? Double(dragState.translation.width / 12) : 0))
                        .animation(.interpolatingSpring(stiffness: 120, damping: 120), value: dragState.translation)
                        .gesture(LongPressGesture(minimumDuration: 0.01)
                        .sequenced(before: DragGesture())
                        .updating($dragState, body: {
                        (value, state, transaction) in
                        switch value {
                        case .first(true):
                            state = .pressing

                        case .second(true, let drag):
                            state = .dragging(translation: drag?.translation ?? .zero)

                        default:
                            break
                        }
                    })
                            .onChanged({ value in
                                
                                guard case .second(true, let drag?) = value else{
                                    return
                                }
                                
                                if drag.translation.width < -dragAreaThreshold {
                                    cardRemovalTransition = .leadingBottom
                                }
                                
                                if drag.translation.width > -dragAreaThreshold {
                                    cardRemovalTransition = .trailingBottom
                                }
                            })
                            .onEnded({value in
                                guard case .second(true, let drag?) = value else {
                                    return
                                }
                                
                                if drag.translation.width < -dragAreaThreshold || drag.translation.width > dragAreaThreshold{
                                    moveCards()
                                }
                            })

                    )
                        .transition(cardRemovalTransition)
                }
            }
                .padding(.horizontal)

            Spacer()

            FooterView(showBookingAlert: $showAlert)
                .opacity(dragState.isDragging ? 0 : 1)
                .animation(.default, value: dragState.isDragging)
        }
            .alert(isPresented: $showAlert, content: {
            Alert(title: Text("SUCCESS"),
                  message: Text("Wishign a lovely and most precious of the times together for the amazing couple."),
                  dismissButton: .default(Text("Happy Honeymoon!"))
            )
        })
            .padding()
            .sheet(isPresented: $showGuide) {
            GuideView()
        }
            .sheet(isPresented: $showInfo) {
            InfoView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
