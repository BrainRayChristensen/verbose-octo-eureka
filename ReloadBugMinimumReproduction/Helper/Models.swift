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
    init(user: User, hours: [Double]) {
        self.user = user
        self.hours = hours
    }
    
    var user:User
    //note, timecard.rows[i].hours[x] is tied to timecard.column[x]
    var hours:[Double]
}

public class User {
    init(serverId: String? = nil, firstName: String? = nil, lastName: String? = nil, employeeId: String? = nil, tradeId: String? = nil) {
        self.serverId = serverId
        self.firstName = firstName
        self.lastName = lastName
        self.employeeId = employeeId
        self.tradeId = tradeId
    }
    
    var serverId: String?
    var firstName: String?
    var lastName: String?
    var employeeId: String?
    var tradeId: String?
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
