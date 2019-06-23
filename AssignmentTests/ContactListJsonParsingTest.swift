//
//  ContactListJsonParsingTest.swift
//  AssignmentTests
//
//  Created by Himanshu Saraswat on 23/06/19.
//  Copyright © 2019 Himanshu Saraswat. All rights reserved.
//

import XCTest
@testable import Assignment

class ContactListJsonParsingTest: XCTestCase {
    
    struct Constant {
        static let contactList = "ContactList"
        static let json = "json"
        static let dummyImageUrl = "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/002/509/original/profile_pic.jpeg?1543383191"
        static let linkedURL = "http://gojek-contacts-app.herokuapp.com/contacts/6121.json"

        
    }
    
    let decoder = JSONDecoder()
    var contactList: [ContactInfo]!

    override func setUp() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: Constant.contactList, ofType: Constant.json)
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        contactList = try! decoder.decode([ContactInfo].self, from: data!)
    }
    
    func testNumberOfContacts() {
        let expectedRows = 6
        
        XCTAssertEqual(contactList.count, expectedRows)
    }
    
    func testCorrectImageRef() {
        let expectedImageURL = Constant.dummyImageUrl
        let row = contactList[0]
        
        XCTAssertEqual(row.profile_pic, expectedImageURL)
    }
    
    func testCorrectLinkedURL() {
        let expectedDescription = Constant.linkedURL
        let row = contactList[0]
        
        XCTAssertEqual(row.url, expectedDescription)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}
