//
//  Schedule.swift
//  Pifagor
//
//  Created by Элина Карапетян on 11.12.2023.
//

import Foundation

struct Schedule: Decodable, Comparable{
    static func < (lhs: Schedule, rhs: Schedule) -> Bool {
        lhs.startTime < rhs.startTime
    }
    
    let subject: String
    let teacher: String
    let startTime: Int
}
