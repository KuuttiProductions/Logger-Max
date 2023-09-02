//
//  ContentView.swift
//  Logger Max
//
//  Created by Kuutti Taavitsainen on 31.8.2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: Lograph
    @State private var inspecting: Bool = false
    @State private var slid: Float = 0
    @State private var current: Int = 0
    
    var body: some View {
        NavigationStack {
            HStack {
                GraphModification(graph: $document.graphs[current])
                LineChart(graph: $document.graphs[current])
                    .padding()
            }
            .navigationSubtitle(document.graphs[current].name)
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {

                } label: {
                    Label("functions.interpolate", systemImage: "chart.xyaxis.line")
                }
                Button {
                    inspecting.toggle()
                } label: {
                    Label("navigation.inspector", systemImage: "sidebar.right")
                }
            }
        }
        .inspector(isPresented: $inspecting) {
            Slider(value: $slid)
        }
    }
}

#Preview {
    ContentView(document: .constant(Lograph()))
}
