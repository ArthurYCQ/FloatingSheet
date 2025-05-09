//
//  HomeView.swift
//  FloatingSheet
//
//  Created by ChuanqingYang on 2025/5/9.
//

import SwiftUI

struct HomeView: View {
    @State private var show: Bool = true
    var body: some View {
        VStack {
            Button {
                show.toggle()
            } label: {
                Text("Show FloatingSheet")
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.indigo)
        .sheetView($show) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Sheet Content")
            }
            .frame(maxWidth: .infinity)
            .frame(height: 300)
            .clipShape(.rect(cornerRadius: 30, style: .continuous))
            .contentShape(.rect(cornerRadius: 30, style: .continuous))
            .background(.ultraThinMaterial)
            .environment(\.colorScheme, .dark)
        }
        
    }
}

#Preview {
    HomeView()
        .environment(\.colorScheme, .light)
}
