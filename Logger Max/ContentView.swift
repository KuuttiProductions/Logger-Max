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

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(document.graphs) { graph in
                    Section {
                        GraphModification(graph: graph)
                    }
                }
            }
        } detail: {
            VStack {
                LineChart(graph: document.graphs[0])
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
            .navigationTitle(document.graphs.first!.name)
            .inspector(isPresented: $inspecting) {
                Slider(value: $slid)
            }
        }
    }
}

#Preview {
    ContentView(document: .constant(Lograph()))
}
