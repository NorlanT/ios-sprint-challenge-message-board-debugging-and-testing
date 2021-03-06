//
//  MessageThreadTests.swift
//  MessageBoardTests
//
//  Created by Andrew R Madsen on 9/13/18.
//  Copyright © 2018 Lambda School. All rights reserved.
//

import XCTest
@testable import Message_Board

class MessageThreadTests: XCTestCase {
    
    let messageThreadController = MessageThreadController()
    
   
    func testCreateThread() {
        let messageTitle = MessageThread(title: "Test")
        let exp = XCTestExpectation(description: "Create Thread")
        
        messageThreadController.createMessageThread(with: messageTitle.title) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        XCTAssertTrue(self.messageThreadController.messageThreads[0].title == "Test")
        XCTAssertTrue(!self.messageThreadController.messageThreads.isEmpty)
    }//

    
    func testCreateMessage() {
        let title = "Michael's Cookies"
        let message = "Did you get the cookies"
        let sender = "Norlan"
        let exp = XCTestExpectation(description: "Create Message")
        
        messageThreadController.createMessageThread(with: title) {
            self.messageThreadController.createMessage(in: self.messageThreadController.messageThreads[0], withText: message, sender: sender) {
                exp.fulfill()
            }
        }
        
        self.wait(for: [exp], timeout: 10)
        XCTAssertEqual(self.messageThreadController.messageThreads[0].messages[0].sender, sender)
    }
    
    
    func testAddSecondMessageToThread() {
        let title = "Michael's Cookies"
        let message = "Did you get the cookies"
        let sender = "Norlan"
        let messageTwo = MessageThread.Message(text: message, sender: sender)
        
        let exp = XCTestExpectation(description: "Create Message")
        
        messageThreadController.messageThreads.append(MessageThread(title: title, messages: [messageTwo], identifier: "4FA24AF4-B9E0-48D2-85C0-C55562C39625"))
        
            self.messageThreadController.createMessage(in: self.messageThreadController.messageThreads[0], withText: "Still Waiting", sender: sender) {
                exp.fulfill()
            }
        
        
        self.wait(for: [exp], timeout: 10)
        XCTAssertEqual(self.messageThreadController.messageThreads[0].messages[0].sender, sender)
    }
    
    
    
    func testFetchMessageThread() {
        let exp = XCTestExpectation()
        
        messageThreadController.fetchMessageThreads {
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(messageThreadController.messageThreads.count, messageThreadController.messageThreads.count)
    }
  
    
    
    func testBaseURL() {
        XCTAssertEqual(MessageThreadController.baseURL, URL(string: "https://journal-ef092.firebaseio.com/"))
    }
    
    
    func testLoadMessage() {
        XCTAssertNotNil(messageThreadController.messageThreads)
    }



    


  

    
    


    
}//
