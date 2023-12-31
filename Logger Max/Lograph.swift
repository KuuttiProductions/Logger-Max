//
//  Logger_MaxDocument.swift
//  Logger Max
//
//  Created by Kuutti Taavitsainen on 31.8.2023.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var lograph: UTType {
        UTType(exportedAs: "com.KudeKube.Logger-Max.lograph")
    }
}

struct Cell: Codable, Identifiable {
    var id = UUID()
    var x: Double
    var y: Double
}

struct GraphData: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var xAxisName: String
    var yAxisName: String
    var xAxisDomain: [Double]
    var yAxisDomain: [Double]
    var cells: [Cell]
    var interpolate: Bool
    
    init(name: String, xAxisName: String, yAxisName: String) {
        self.name = name
        self.xAxisName = xAxisName
        self.yAxisName = yAxisName
        self.xAxisDomain = [0, 1]
        self.yAxisDomain = [0, 1]
        self.cells = [
            Cell(x: 0, y: 0),
            Cell(x: 0, y: 0),
            Cell(x: 0, y: 0),
            Cell(x: 0, y: 0),
            Cell(x: 0, y: 0)
        ]
        self.interpolate = false
    }
    
    init(name: String, xAxisName: String, yAxisName: String, cells: [Cell]) {
        self.name = name
        self.xAxisName = xAxisName
        self.yAxisName = yAxisName
        self.yAxisName = yAxisName
        self.xAxisDomain = [0, 1]
        self.yAxisDomain = [0, 1]
        self.cells = cells
        self.interpolate = false
    }
}

struct Lograph: FileDocument, Codable {
    
    var graphs: [GraphData]
    
    init() {
        let defaultGraph = GraphData(name: "", xAxisName: "X", yAxisName: "Y")
        self.graphs = [defaultGraph]
    }

    static var readableContentTypes: [UTType] { [.lograph] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.graphs = try! JSONDecoder().decode(Self.self, from: data).graphs
        self.graphs[0].interpolate = false
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try! JSONEncoder().encode(self)
        let fileWrapper = FileWrapper(regularFileWithContents: data)
        return fileWrapper
    }
}
