//
//  ContentView.swift
//  Logger Max
//
//  Created by Kuutti Taavitsainen on 31.8.2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: Logger_MaxDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(Logger_MaxDocument()))
}
