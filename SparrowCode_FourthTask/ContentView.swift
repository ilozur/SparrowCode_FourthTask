//
//  ContentView.swift
//  SparrowCode_FourthTask
//
//  Created by Edmond Podlegaev on 10.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var performAnimation = false
    
    var body: some View {
        Button {
            if !performAnimation {
                withAnimation(.interpolatingSpring(stiffness: 170, damping: 15)) {
                    performAnimation = true
                } completion: {
                    performAnimation = false
                }
            }
        } label: {
            GeometryReader { proxy in
                
                let width = proxy.size.width / 2
                let systemName = "play.fill"
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? width : .zero)
                        .opacity(performAnimation ? 1 : .zero)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: systemName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: performAnimation ? 0.5 : width)
                        .opacity(performAnimation ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .frame(maxWidth: 65)
        .buttonStyle(NextTrack())
    }
}

struct NextTrack: ButtonStyle {
    @State private var isAction: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .foregroundStyle(.secondary)
                .opacity(isAction ? 0.25 : 0)
            configuration.label
                .padding(15)
        }
        .scaleEffect(isAction ? 0.86 : 1)
        .animation(.easeInOut(duration: 0.22), value: configuration.isPressed)
        .onChange(of: configuration.isPressed) {
            if configuration.isPressed {
                withAnimation(.easeInOut(duration: 0.22)) {
                    isAction = true
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                    withAnimation(.easeInOut(duration: 0.22)) {
                        isAction = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
