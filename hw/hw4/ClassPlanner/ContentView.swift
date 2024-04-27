//
//  ContentView.swift
//  ClassPlanner
//
//  Created by Justin Wong on 2/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var cpsmanager = CPScheduleManager()
    
    private var sortedYearPlans: [CPYearPlan] {
        return cpsmanager.sortedYearPlans
    }
    
    private var currentYearString: String {
        String(sortedYearPlans[cpsmanager.currentYearPlanIndex].year)
    }
    
    private var currentYear: Int {
        sortedYearPlans[cpsmanager.currentYearPlanIndex].year
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                yearTimelineView
                TabView(selection: $cpsmanager.currentYearPlanIndex,
                        content:  {
                    ForEach(Array(sortedYearPlans.enumerated()), id: \.offset) { index, yearPlan in
                        SemesterListView(yearPlan: yearPlan, isInEditMode: cpsmanager.isInEditMode)
                            .tag(index)
                    }
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                })
                .padding()
                .tabViewStyle(.page)
            }
            .navigationTitle("My Plan")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        cpsmanager.isPresentingAddClassSheet.toggle()
                    }) {
                        Image(systemName: "plus")
                            .bold()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        withAnimation {
                            cpsmanager.isInEditMode.toggle()
                        }
                    }) {
                        Text(cpsmanager.isInEditMode ? "Done" : "Edit")
                            .bold()
                    }
                    Button(action: {
                        cpsmanager.isPresentingThemeColorSheet.toggle()
                    }) {
                        Circle()
                            .fill(cpsmanager.themeColor.opacity(0.3))
                            .frame(width: 40, height: 40)
                            .overlay(
                                Circle()
                                    .fill(cpsmanager.themeColor)
                                    .frame(width: 30, height: 30)
                            )
                    }
                }
            }
            .fullScreenCover(isPresented: $cpsmanager.isPresentingThemeColorSheet) {
                ThemeColorPaletteView()
                    .environment(cpsmanager)
            }
            .sheet(isPresented: $cpsmanager.isPresentingAddClassSheet) {
                AddClassView(yearPlans: cpsmanager.yearPlans)
                    .environment(cpsmanager)
            }
            .tint(cpsmanager.themeColor)
        }
    }
    
    private var yearTimelineView: some View {
        HStack {
            yearTimelineLeftButton
            
            Spacer()
            Text(currentYearString)
                .font(.system(size: 35))
                .fontWeight(.heavy)
                .contentTransition(.numericText(value: Double(currentYearString)!))
            Spacer()
            
            yearTimelineRightButton
        }
        .padding()
    }
    
    private var yearTimelineLeftButton: some View {
        Button(action: {
            withAnimation {
                if cpsmanager.currentYearPlanIndex - 1 < 0 {
                    let newYearPlan = CPYearPlan(year: currentYear - 1, semesters: [
                        CPSemester(type: .fall, classes: []),
                        CPSemester(type: .spring, classes: [])
                    ])
                    cpsmanager.yearPlans.append(newYearPlan)
                } else {
                    cpsmanager.currentYearPlanIndex -= 1
                }
            }
        }) {
            if cpsmanager.currentYearPlanIndex - 1 < 0 {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(Color.green)
            } else {
                Image(systemName: "chevron.left.circle.fill")
            }
        }
        .font(.system(size: 30))
    }
    
    private var yearTimelineRightButton: some View {
        Button(action: {
            withAnimation {
                if cpsmanager.currentYearPlanIndex + 1 >= cpsmanager.yearPlans.count {
                    let newYearPlan = CPYearPlan(year: currentYear + 1, semesters: [
                        CPSemester(type: .fall, classes: []),
                        CPSemester(type: .spring, classes: [])
                    ])
                    cpsmanager.yearPlans.append(newYearPlan)
                }
                cpsmanager.currentYearPlanIndex += 1
            }
        }) {
            if cpsmanager.currentYearPlanIndex + 1 >= cpsmanager.yearPlans.count {
                Image(systemName: "plus.circle.fill")
                    .foregroundStyle(Color.green)
  
            } else {
                Image(systemName: "chevron.right.circle.fill")
            }
            
        }
        .font(.system(size: 30))
    }
}


#Preview {
    ContentView()
}
