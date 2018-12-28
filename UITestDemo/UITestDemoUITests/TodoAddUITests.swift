//
//  TodoAddUITests.swift
//  UITestDemoUITests
//
//  Created by Grey.Luo on 2018/11/14.
//  Copyright © 2018 Sioeye. All rights reserved.
//

import XCTest

class TodoAddUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testShouldNotShowAlert() {
        let app = XCUIApplication()
        app.navigationBars["To Do List"].buttons["Add"].tap()

        let textField = app.textFields["todotextfield"]
        textField.tap()

        textField.typeText("something")

        app.buttons["Save"].tap()
        let alerts = app.alerts
        let label = alerts.staticTexts["Empty to do content"]

        let labelExist = NSPredicate(format: "exists == 0")
        let exp = expectation(for: labelExist, evaluatedWith: label, handler: nil)

        wait(for: [exp], timeout: 5)
    }

    func testEmptySave() {
        let app = XCUIApplication()
        app.navigationBars["To Do List"].buttons["Add"].tap()

        let textField = app.textFields["todotextfield"]

        app.buttons["Save"].tap()
        let alerts = app.alerts
        let label = alerts.staticTexts["Empty to do content"]

        let alertCount = NSPredicate(format: "count == 1")
        let labelExist = NSPredicate(format: "exists == 1")

        let expectation1 = expectation(for: alertCount, evaluatedWith: alerts, handler: nil)
        let expectation2 = expectation(for: labelExist, evaluatedWith: label, handler: nil)

        wait(for: [expectation1, expectation2], timeout: 5)
    }

    func testAddNewItem() {
        let app = XCUIApplication()
        let table = app.tables.element(boundBy: 0)
        let oldCount = table.cells.count

        app.navigationBars["To Do List"].buttons["Add"].tap()

        let textfield = app.textFields["todotextfield"]
        let text = "something"
        textfield.tap()
        textfield.typeText(text)

        app.buttons["Save"].tap()

        let count = table.cells.count
        XCTAssert(count == oldCount+1)

        let theNewCell = table.cells.element(boundBy: count-1)

        let theNewText = theNewCell.staticTexts.element(boundBy: 0).label

        let showText = "\(count-1) " + text
        XCTAssertEqual(theNewText, showText)

        app.tables.children(matching: .cell).buttons["Fold"].tap()


    }
}
