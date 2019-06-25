//
//  AssignmentAsyncTest.swift
//  AssignmentTests
//
//  Created by Himanshu Saraswat on 23/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import XCTest
@testable import Assignment


class AssignmentAsyncTest: XCTestCase {
    
    struct Constants {
        static let StatusCodeDict = "Status code : 200"
        static let completionHandlerMsg = "Call completes immediately by invoking completion handler"
    }

    var sessionUnderTest : URLSession!

    override func setUp() {
        sessionUnderTest = URLSession(configuration : URLSessionConfiguration.default)
    }

    override func tearDown() {
        sessionUnderTest = nil
    }
    
    func testValidCallToInfoAPIGetsStatusCode200(){
        let request = NetworkDataLoaderConstant.baseUrlString.urlRequest()
        let promise = expectation(description: Constants.StatusCodeDict)
        
        // when
        sessionUnderTest.dataTask(with: request) { (data, response, error) in
            // then
            if let error = error{
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else{
                    XCTFail("Status code = \(statusCode)")
                }
            }
            }.resume()
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // Fast Fail
    func testCallToInfoAPIServerCompletes() {
        // Given
        let request = NetworkDataLoaderConstant.baseUrlString.urlRequest()
        let promise = expectation(description: Constants.completionHandlerMsg)
        var statusCode : Int?
        var responseError : Error?
        
        // When
        sessionUnderTest.dataTask(with: request) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
            }.resume()
        waitForExpectations(timeout: 5, handler: nil)
        
        // Then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode!, 200)
    }

}
