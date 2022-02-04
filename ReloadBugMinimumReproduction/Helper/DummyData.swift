//
//  DummyData.swift
//  ReloadBugMinimumReproduction
//
//  Created by Brian Christensen on 2/4/22.
//

import Foundation

class DummyData {
    
    static let costCodes = [
        CostCode(costCode: "cost-1234", jobCode: "job-1234", costCodeTitle: "my cost code", jobTitle: "my job")
    ]
    
    static let users = [
        User(serverId: "user1234", firstName: "bob", lastName: "Fred", employeeId: "#1", tradeId: "BOSS")
    ]
}
