//
//  ComputationCache.swift
//  TableViewDemoTest
//
//  Created by Ashwini Apurkar on 29/05/24.
//

import Foundation

class ComputationCache {
    static let shared = ComputationCache()
    private var cache = NSCache<NSNumber, NSNumber>()
    
    private init() {}
    
    func performComputation(for id: Int) -> Double {
        if let cachedResult = cache.object(forKey: NSNumber(value: id)) {
            return cachedResult.doubleValue
        } else {
            let startTime = Date()
            // Simulate heavy computation
            for _ in 0..<1000000 { _ = 1 + 1 }
            let endTime = Date()
            let timeInterval = endTime.timeIntervalSince(startTime)
            cache.setObject(NSNumber(value: timeInterval), forKey: NSNumber(value: id))
            return timeInterval
        }
    }
}
