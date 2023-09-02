//
//  GraphModification.swift
//  Logger Max
//
//  Created by Kuutti Taavitsainen on 31.8.2023.
//

import SwiftUI

struct GraphModification: View {
    @Binding var graph: GraphData
    
    var body: some View {
        VStack {
            TextField("graph.name", text: $graph.name)
                .font(.title)
                .multilineTextAlignment(.center)
                .textFieldStyle(.plain)
            HStack {
                TextField("x.axis", text: $graph.xAxisName)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
                TextField("y.axis", text: $graph.yAxisName)
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .textFieldStyle(.plain)
                    .multilineTextAlignment(.center)
            }
            List {
                ForEach($graph.cells, id: \.id) { $cell in
                    HStack {
                        TextField("x", value: $cell.x, format: .number)
                            .textFieldStyle(.squareBorder)
                        TextField("y", value: $cell.y, format: .number)
                            .textFieldStyle(.squareBorder)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            graph.cells.removeLast()
                        } label: {
                            Label("button.remove", systemImage: "trash")
                        }
                    }
                }
                Button {
                    graph.cells.append(Cell(x: 0, y: 0))
                } label: {
                    Label("button.addCell", systemImage: "plus")
                }
            }
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .listSectionSeparator(.hidden)
        }
    }
}

#Preview {
    GraphModification(graph: .constant(GraphData(name: "Kävelijä nopea", xAxisName: "x(m)", yAxisName: "t(s)")))
}
