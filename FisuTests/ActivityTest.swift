//
//  ActivityTest.swift
//  Fisu
//
//  Created by Djeneba KANE on 11/04/2016.
//  Copyright © 2016 Nassim VACHOR. All rights reserved.
//

import XCTest
@testable import Fisu

class ActivityTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testActivtyInsert()
    {
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        
        ///- l'insertion d'une nouvelle activity
        let day8 = Day.insertNewDay(moc, id: 8, day: "Day 8")
        let activite1 = Activity.insertNewActivity(moc, id: 100, nom: "Open Ceremony", desc: "Speech about FISU and all events", dateD: "04/07/2016, 09:00", dateF: "04/07/2016, 12:30", lieu: nil, speak: nil, photo: "ceremony", day: day8, selected: false)
        XCTAssertNotNil(activite1, "L'insertion de activite1 c'est bien passee")
       let activite2 = Activity.insertNewActivity(moc, id: 100, nom: "Open Ceremony", desc: "Speech about FISU and all events", dateD: "04/07/2016, 09:00", dateF: "04/07/2016, 12:30", lieu: nil, speak: nil, photo: "ceremony", day: day8, selected: false)
        
        
        ///- Si jamais on insere une activity qui a deja ete insere, il n y pas d erreur ni de nouvelle insertion: l'activity qui avait ete insere est juste retourne
        XCTAssertEqual(activite1, activite2, "L activite1 et l activite2 ne correspondent pas au meme activity")
        
    }
    
    
    func testgetDay()
    {
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        
        let day8 = Day.insertNewDay(moc, id: 8, day: "Day 8")
        
        let activite1 = Activity.insertNewActivity(moc, id: 1000, nom: "Open Ceremony", desc: "Speech about FISU and all events", dateD: "04/07/2016, 09:00", dateF: "04/07/2016, 12:30", lieu: nil, speak: nil, photo: "ceremony", day: day8, selected: false)
        
        ///- permet de recuperer le day correspondant a activite1
    
            XCTAssertEqual(activite1!.getDay(),"Monday, July 4, 2016")
        
    }
    
 
    
// fonction permettant de tester la foction  getTimeDeb et getTimeFin, qui retourne la date de debut d'une activite sous forme de String
  func testgetTimeDebFin()
   {
    
    let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
    
    let day8 = Day.insertNewDay(moc, id: 8, day: "Day 8")
    
    // initialisation d une activity ayant lieu le 8eme jour
    let activite1 = Activity.insertNewActivity(moc, id: 1003, nom: "Open Ceremony", desc: "Speech about FISU and all events", dateD: "04/08/2016, 12:00", dateF: "04/08/2016, 13:00", lieu: nil, speak: nil, photo: "ceremony", day: day8, selected: false)
    
    // verification de l egalite entre "12:00 PM" (correspondant a dateD de activite1) et la date de debut de activite1
      XCTAssertEqual(activite1!.getTimeDeb(),"12:00 PM")
    
     /// verification de l egalite entre "1:00 PM" (correspondant a dateF de activite1) et la date de fin de activite1
     XCTAssertEqual(activite1!.getTimeFin(),"1:00 PM")
    
    }
    
    
    func testUpdate()
    {
        
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        let day8 = Day.insertNewDay(moc, id: 8, day: "Day 8")
        
        // initialisation d une activity ayant lieu le 8eme jour
        let activite1 = Activity.insertNewActivity(moc, id: 1003, nom: "Open Ceremony", desc: "Speech about FISU and all events", dateD: "04/08/2016, 12:00", dateF: "04/08/2016, 13:00", lieu: nil, speak: nil, photo: "ceremony", day: day8, selected: false)
        
        Activity.updateData(1, KeyPath: "selected" , id: 1003)
        XCTAssertEqual(activite1?.selected, 1)
        
        
        
    }
    

    
}
