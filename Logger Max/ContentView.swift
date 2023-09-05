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
    @State private var showInfo: Bool = false
    @State private var intercept: Double = 0.0
    @State private var slope: Double = 0.0
    
    var body: some View {
        NavigationStack {
            HStack {
                GraphModification(graph: $document.graphs[current])
                    .frame(minWidth: 100, maxWidth: 300, minHeight: 200)
                LineChart(graph: $document.graphs[current],
                          showInterpolation: $document.graphs[current].interpolate,
                          intercept: $intercept,
                          slope: $slope)
                    .frame(minWidth: 200, minHeight: 200)
            }
            .navigationSubtitle(document.graphs[current].name)
            .frame(minWidth: 400)
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {
                    showInfo.toggle()
                } label: {
                    Label("graph.showInfo", systemImage: "info.circle")
                }
                .popover(isPresented: $showInfo, attachmentAnchor: .point(.center), arrowEdge: .bottom) {
                    VStack {
                        Text("slope.text: \(slope)")
                        Text("intercept.text: \(intercept)")
                    }
                    .padding()
                }
                Button {
                    document.graphs[current].interpolate.toggle()
                    linearRegression()
                } label: {
                    Label("functions.interpolate", systemImage: "chart.xyaxis.line")
                }
                Spacer()
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
        .onAppear() {
            linearRegression()
        }
    }

    func linearRegression() {
        let points = document.graphs[current].cells
        let n = Double(points.count)
        
        // Calculate the sum of x, y, xy, x^2
        let sumX = points.reduce(0) { $0 + $1.x }
        let sumY = points.reduce(0) { $0 + $1.y }
        
        var sumXY: Double = 0.0
        var sumX2: Double = 0.0
        
        for point in points {
            sumXY += point.x * point.y
            sumX2 += point.x * point.x
        }
        
        // Calculate the slope (m) and intercept (b)
        slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX)
        intercept = (sumY - slope * sumX) / n
    }
}

#Preview {
    ContentView(document: .constant(Lograph()))
}
