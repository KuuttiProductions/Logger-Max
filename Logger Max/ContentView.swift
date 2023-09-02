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
    @State private var current: Int = 0
    
    var body: some View {
        NavigationStack {
            HStack {
                GraphModification(graph: $document.graphs[current])
                    .frame(minWidth: 100, maxWidth: 300, minHeight: 200)
                LineChart(graph: $document.graphs[current],
                          showInterpolation: $document.graphs[current].interpolate)
                    .frame(minWidth: 200, minHeight: 200)
            }
            .navigationSubtitle(document.graphs[current].name)
            .frame(minWidth: 400)
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {
                    document.graphs[current].interpolate.toggle()
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
            Text("inspector.graph")
                .font(.title)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.leading)
            Form {
                HStack {
                    TextField("x.axis", value: $document.graphs[current].xAxisDomain[0], format: .number)
                    TextField("x.axis", value: $document.graphs[current].xAxisDomain[1], format: .number)
                }
                HStack {
                    TextField("x.axis", value: $document.graphs[current].yAxisDomain[0], format: .number)
                    TextField("x.axis", value: $document.graphs[current].yAxisDomain[1], format: .number)
                }
            }
            .inspectorColumnWidth(min: 200, ideal: 300, max: 400)
        }
    }
}

#Preview {
    ContentView(document: .constant(Lograph()))
}
