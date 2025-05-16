//
//  TaskSwiftApp.swift
//  TaskSwift
//
//  Created by PC-0065_Kota.Akatsuka on 2025/05/17.
//

import SwiftUI
import SwiftData

@main
struct TaskSwiftApp: App {
    init() {
        // ナビゲーションバーのカスタマイズ
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 45/255, green: 45/255, blue: 45/255, alpha: 1.0)
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        // ナビゲーションバーのアイコンとテキストの色
        UITabBar.appearance().tintColor = UIColor(red: 79/255, green: 127/255, blue: 255/255, alpha: 1.0)
        
        // ナビゲーションバーの非選択時の色
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 176/255, green: 179/255, blue: 184/255, alpha: 1.0)
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
