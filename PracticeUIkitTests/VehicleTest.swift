//
//  VehicleTest.swift
//  PracticeUIkitTests
//
//  Created by New User on 18/04/2024.
//

import XCTest
@testable import PracticeUIkit

final class VehicleTest: XCTestCase {
    
    var mercedes: Vehicle!
    var boeing: Vehicle!
    
    override func setUpWithError() throws {
        mercedes = Vehicle(type: .Car)
        boeing = Vehicle(type: .PassengerAircraft)
    }
    
    override func tearDownWithError() throws {
        mercedes = nil
        boeing = nil
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPlaneFasterThanCar() {
        //Act
        let minutes = 60
        
        //Arrenge
        mercedes.startEngine(minutes: minutes)
        boeing.startEngine(minutes: minutes)
        
        //Assert
        XCTAssertTrue(boeing.returnMiles() > mercedes.returnMiles())
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAddition() {
            // Arrange
            let num1 = 5
            let num2 = 10
            
            // Act
            let result = add(num1, num2)
            
            // Assert
            XCTAssertEqual(result, 15, "Addition is incorrect")
        }
        
        func add(_ num1: Int, _ num2: Int) -> Int {
            return num1 + num2
        }
    
    func testFetchPostList() {
        let exp = expectation(description:"fetching post list from server")
        let session: URLSession = URLSession(configuration: .default)
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        guard let customUrl = url else { return }
        
        session.dataTask(with: customUrl) { data, response, error in
            XCTAssertNotNil(data)
            exp.fulfill()
        }.resume()
        waitForExpectations(timeout: 5.0) { (error) in
            print(error?.localizedDescription ?? "error")
        }
    }
    
}
