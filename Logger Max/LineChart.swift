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
    
    var body: some View {
        VStack {
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
                        y: .value(graph.yAxisName, linearRegression().intercept)
                    )
                    LineMark(
                        x: .value(graph.xAxisName, getLastPos()),
                        y: .value(graph.yAxisName, linearRegression().intercept + linearRegression().slope*getLastPos())
                    )
                }
            }
            .chartLegend(.hidden)
            .chartXAxisLabel(graph.xAxisName)
            .chartYAxisLabel(graph.yAxisName)
            .foregroundStyle(Gradient(colors: [.cyan, .blue]))
            .chartXScale(domain: graph.xAxisDomain)
            .chartYScale(domain: graph.yAxisDomain)
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
    
    func linearRegression()-> (slope: Double, intercept: Double) {
        let points = graph.cells
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
        let slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX)
        let intercept = (sumY - slope * sumX) / n
        
        return (slope, intercept)
    }
}

#Preview {
    LineChart(graph: .constant(GraphData(name: "Nopea liikkuja", xAxisName: "t(s)", yAxisName: "x(m)", cells: [Cell(x: 0, y: 0), Cell(x: 3, y: 1.8), Cell(x: 6, y: 7.6)])), showInterpolation: .constant(true))
}
