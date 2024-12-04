//
//  firetestApp.swift
//  firetest
//
//  Created by Faysal Mahmud on 5/12/24.
//

import SwiftUI
import Firebase
@main
struct firetestApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
