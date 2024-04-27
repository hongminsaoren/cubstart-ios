//
//  CPScheduleManager.swift
//  ClassPlanner
//
//  Created by Justin Wong on 2/23/24.
//

import SwiftUI

//TODO: - 4B. Implement CPScheduleManager
@Observable class CPScheduleManager: Identifiable{
    var yearPlans = CPSampleData.yearPlans
    var currentYearPlanIndex: Int = 0
    var isPresentingAddClassSheet = false
    var isPresentingThemeColorSheet = false
    var isInEditMode = false
    var themeColor : Color=Color.blue
    init(yearPlans: [CPYearPlan]=CPSampleData.yearPlans, themeColor: Color=Color.blue) {
        self.yearPlans = yearPlans
        self.themeColor = themeColor
    }
    var allClasses: [CPClass]{
        return yearPlans.flatMap { yearPlan in
                yearPlan.semesters.flatMap { semester in
                    semester.classes
                }
            }
    }
    var sortedYearPlans: [CPYearPlan]{
        yearPlans.sorted(by: {$0.year<$1.year})
    }
    
}
