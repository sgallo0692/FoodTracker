//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Stephen Gallo on 6/6/16.
//  Copyright © 2016 Stephen Gallo. All rights reserved.
//

import UIKit
import XCTest

class FoodTrackerTests: XCTestCase {
    // MARK: FoodTracker Tests
    func testMealInitialization() {
        //on success
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        //failure case
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    }
}
