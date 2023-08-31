//
//  GraphModification.swift
//  Logger Max
//
//  Created by Kuutti Taavitsainen on 31.8.2023.
//

import SwiftUI

struct GraphModification: View {
    @State var graph: GraphData
    
    var body: some View {
        VStack {
            Text(graph.name)
            List($graph.cells) { $cell in
                Text(String(cell.x))
            }
        }
    }
}
