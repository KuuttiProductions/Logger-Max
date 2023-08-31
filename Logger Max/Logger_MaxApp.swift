//
//  Logger_MaxApp.swift
//  Logger Max
//
//  Created by Kuutti Taavitsainen on 31.8.2023.
//

import SwiftUI

@main
struct Logger_MaxApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: Logger_MaxDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
