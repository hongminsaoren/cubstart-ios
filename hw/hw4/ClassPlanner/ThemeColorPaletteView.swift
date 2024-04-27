//
//  ThemeColorPaletteView.swift
//  ClassPlannerFinished
//
//  Created by Justin Wong on 2/23/24.
//

import SwiftUI

struct ThemeColorPaletteView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment (CPScheduleManager.self) private var manager
    @State private var themeColor: Color = Color.blue
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 30) {
                selectedColorHeader
                colorGrid
            }
            .navigationTitle("Set Theme Color")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                    }
                }
            }
        }
    }
    private var selectedColorHeader: some View {
        HStack(spacing: 20) {
            Text("Selected Theme Color:")
                .font(.title).bold()
            RoundedRectangle(cornerRadius: 10)
                .fill(manager.themeColor)
                .frame(width: 50, height: 50)
        }
    }
    private var colorGrid: some View {
        @Bindable var man=manager
        return
        Grid(horizontalSpacing: 30) {
            GridRow {
                ColorCircleView(selectedColor: $man.themeColor, color: .red)
                ColorCircleView(selectedColor: $man.themeColor, color: .green)
                ColorCircleView(selectedColor: $man.themeColor, color: .blue)
            }
            GridRow {
                ColorCircleView(selectedColor: $man.themeColor, color: .purple)
                ColorCircleView(selectedColor: $man.themeColor, color: .yellow)
                ColorCircleView(selectedColor: $man.themeColor, color: .black)
            }
            GridRow {
                ColorCircleView(selectedColor: $man.themeColor, color: .brown)
                ColorCircleView(selectedColor: $man.themeColor, color: .cyan)
                ColorCircleView(selectedColor: $man.themeColor, color: .indigo)
            }
        }
    }
}

//MARK: - ColorCircleView
struct ColorCircleView: View {
    @Binding var selectedColor: Color
    
    var color: Color
    
    var body: some View {
        Circle()
            .fill(selectedColor == color ? .indigo.opacity(0.2) : .clear)
            .frame(width: 100, height: 100)
            .overlay(
                Circle()
                    .fill(color)
                    .frame(width: 80, height: 80)
            )
            .onTapGesture {
                selectedColor = color
            }
    }
}


#Preview {
    ThemeColorPaletteView()
        .environment(CPScheduleManager())
        
}


