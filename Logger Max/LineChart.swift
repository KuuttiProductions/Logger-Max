//
//  LineChart.swift
//  Logger Max
//
//  Created by Kuutti Taavitsainen on 31.8.2023.
//

import SwiftUI
import Charts

struct LineChart: View {
    @Binding var graph: GraphData
    
    var body: some View {
        VStack {
            Chart {
                ForEach(graph.cells, id: \.id) { cell in
                    LineMark(
                        x: .value(graph.xAxisName, cell.x),
                        y: .value(graph.yAxisName, cell.y)
                    )
                }
                .interpolationMethod(.cardinal)
                .foregroundStyle(Gradient(colors: [.cyan, .blue]))
                .lineStyle(StrokeStyle(lineWidth: 5, lineCap: .round))
            }
            .chartLegend(.hidden)
            .chartXAxisLabel(graph.xAxisName)
            .chartYAxisLabel(graph.yAxisName)
//            .chartXScale(domain: [0, 8])
//            .chartYScale(domain: [0, 10])
        }
        .padding()
    }
}

//#Preview {
//    LineChart(graph: .constant(GraphData(name: "Nopea liikkuja", xAxisName: "t(s)", yAxisName: "x(m)", cells: [Cell(x: 0, y: 0), Cell(x: 3, y: 1.8), Cell(x: 6, y: 7.6)])))
//}
