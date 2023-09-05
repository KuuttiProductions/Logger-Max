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
    @Binding var showInterpolation: Bool
    @Binding var intercept: Double
    @Binding var slope: Double
    @State private var rawSelectedPos: Double?
    var selectedPos: Double? { return rawSelectedPos }
    
    var body: some View {
        VStack {
            Spacer(minLength: 30.0)
            Chart {
                ForEach(graph.cells, id: \.id) { cell in
                    PointMark(
                        x: .value(graph.xAxisName, cell.x),
                        y: .value(graph.yAxisName, cell.y)
                    )
                }
                .interpolationMethod(.cardinal)
                .lineStyle(StrokeStyle(lineWidth: 5, lineCap: .round))
                .alignsMarkStylesWithPlotArea()
                if showInterpolation {
                    LineMark(
                        x: .value(graph.xAxisName, 0),
                        y: .value(graph.yAxisName, intercept)
                    )
                    LineMark(
                        x: .value(graph.xAxisName, getLastPos()),
                        y: .value(graph.yAxisName, intercept + slope*getLastPos())
                    )
                }
                if let selectedPos {
                    RuleMark(x: .value("x", selectedPos))
                        .zIndex(-1)
                        .foregroundStyle(.gray)
                        .offset(yStart: -10)
                        .annotation(position: .top,
                                    spacing: 0,
                                    overflowResolution: .init(
                                        x: .fit(to: .chart),
                                        y: .disabled
                                    )) {
                                        GraphSelection(yAxisName: $graph.yAxisName,
                                                       yValue: selectedPos)
                                    }
                }
            }
            .chartXAxisLabel(graph.xAxisName)
            .chartYAxisLabel(graph.yAxisName)
            .foregroundStyle(Color.accent)
            .chartXScale(domain: graph.xAxisDomain)
            .chartYScale(domain: graph.yAxisDomain)
            .chartXSelection(value: $rawSelectedPos)
        }
        .padding()
    }
    
    func getLastPos()-> Double {
        var furthest = 0.0
        for point in graph.cells {
            if point.x > furthest {
                furthest = point.x
            }
        }
        return furthest
    }
}

struct GraphSelection: View {
    @Binding var yAxisName: String
    var yValue: Double?
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .foregroundStyle(.gray.quinary)
            VStack(alignment: .leading) {
                Text("graph.point.values")
                    .fontWeight(.semibold)
                Text("\(yAxisName): \(yValue!)")
            }
            .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
        }
    }
}

#Preview {
    LineChart(graph: .constant(GraphData(name: "h", xAxisName: "X", yAxisName: "Y",
                               cells: [Cell(x: 0, y: 0), Cell(x: 1, y: 1)])),
              showInterpolation: .constant(true),
              intercept: .constant(0.0),
              slope: .constant(1.0))
}
