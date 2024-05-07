//
//  SystemScanTest.swift
//  PracticeUIkitTests
//
//  Created by New User on 18/04/2024.
//

import XCTest
@testable import PracticeUIkit

final class SystemScanTest: XCTestCase {

    
    var systemScanViewController: SystemScanViewController!
    
    override func setUp() {
        super.setUp()
        
    }
    
    func testAdditionOfNumbers(){
        let num1 = 5
        let num2 = 10
        
        let result = systemScanViewController.additionOfNumbers(num1: num1, num2: num2)
        XCTAssertEqual(result, 25, "Addition result should be 15")
    }
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "SystemScan", bundle: nil)
        systemScanViewController = storyboard.instantiateViewController(withIdentifier: "SystemScanViewController") as? SystemScanViewController
        _ = systemScanViewController.view
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
    
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
