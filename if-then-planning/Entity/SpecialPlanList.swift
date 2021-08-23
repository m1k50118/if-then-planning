//
//  SpecialPlanList.swift
//
//  Created by 佐藤真 on 2021/08/21.
//

import Foundation
struct SpecialPlanList {
    var plans: [Plan]
    enum Special {
        case today
        case scheduled
        case all
        case flagged
    }
}
