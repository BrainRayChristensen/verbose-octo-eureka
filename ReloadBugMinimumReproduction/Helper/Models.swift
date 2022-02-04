//
//  Models.swift
//  ReloadBugMinimumReproduction
//
//  Created by Brian Christensen on 2/4/22.
//

import Foundation

class Timecard {
    var date: Date
    var rows:[Row]
    var columns:[Column]
    
    init(date: Date, rows: [Row], columns: [Column]) {
        self.date = date
        self.rows = rows
        self.columns = columns
    }
}

class Row {
    init(hours: [Double]) {
        self.hours = hours
    }
    
    //note, timecard.rows[i].hours[x] is tied to timecard.column[x]
    var hours:[Double]
}

class Column {
    init(costCode: CostCode) {
        self.costCode = costCode
    }
    
    var costCode: CostCode
}

class CostCode {
    internal init(costCode: String? = nil, jobCode: String? = nil, costCodeTitle: String? = nil, jobTitle: String? = nil) {
        self.costCode = costCode
        self.jobCode = jobCode
        self.costCodeTitle = costCodeTitle
        self.jobTitle = jobTitle
        self.fullCode = (jobCode ?? "") + " - " + (costCode ?? "")
    }
    
    var costCode:String?
    var jobCode:String?
    var costCodeTitle:String?
    var jobTitle:String?
    var fullCode:String?

}
