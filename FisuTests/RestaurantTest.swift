//
//  RestaurantTest.swift
//  Fisu
//
//  Created by Djeneba KANE on 11/04/2016.
//  Copyright © 2016 Nassim VACHOR. All rights reserved.
//

import XCTest
@testable import Fisu

class RestaurantTest: XCTestCase {
    
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
    
    
    func testInsertRestaurant()
    {
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext

     let res1 =  Restaurant.insertNewRestaurant(moc, id: 1000, nom: "Domino's Pizza", spec:"Pizza", dateD :"04/07/2016, 11:00", dateF:"01/07/2016, 23:30", adresse: nil , tel: "06 67 79 29 20", photo: "Domino's", rating: "star5")
        
          XCTAssertNotNil(res1, "L'insertion de res1 c'est mal bien passee")
        
        let res2 =  Restaurant.insertNewRestaurant(moc, id: 1000, nom: "Domino's Pizza", spec:"Pizza", dateD :"04/07/2016, 11:00", dateF:"01/07/2016, 23:30", adresse: nil , tel: "06 67 79 29 20", photo: "Domino's", rating: "star5")
        
        
        // verification de l'egalite entre res1 et res2
        ///- Si jamais on insere un restaurant  qui a deja ete insere, il n'y pas d erreur ni de nouvelle insertion: le restaurant qui avait ete insere est juste retourne
        XCTAssertEqual(res1, res2, "res1 et res2 ne correspondent pas au meme restaurant")
        
        // nettoyage de la base apres les test
        Restaurant.deleteData(1000)
      
        
    }
    
    
    func testgetDay()
    {
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        
        let res1 =  Restaurant.insertNewRestaurant(moc, id: 1000, nom: "Domino's Pizza", spec:"Pizza", dateD :"04/07/2016, 11:00", dateF:"01/07/2016, 23:30", adresse: nil , tel: "06 67 79 29 20", photo: "Domino's", rating: "star5")
        
        ///- permet de recuperer le day correspondant a res1
        
        XCTAssertEqual(res1!.getDay(),"Monday, July 4, 2016")
        
        // nettoyage de la base apres les test
        Restaurant.deleteData(1000)

        
    }
    
    // test de la fonction convertStringToNSDate : permettant de trasformer un string en NSDate
    func testconvertStringToNSDate()
    {
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        
        // initialisation d une Restaurant ayant lieu le 8eme jour
         let res1 =  Restaurant.insertNewRestaurant(moc, id: 1000, nom: "Domino's Pizza", spec:"Pizza", dateD :"04/07/2016, 11:00", dateF:"01/07/2016, 23:30", adresse: nil , tel: "06 67 79 29 20", photo: "Domino's", rating: "star5")
        
        // res1!.dateFin est un NSDate
        XCTAssertEqual(res1!.hourdeb ,Restaurant.convertStringToNSDate("04/07/2016, 11:00"), " ces deux NSDate ne sont pas egales")
        
        // nettoyage de la base apres les test
      Restaurant.deleteData(1000)
       
        
        
    }
    // fonction permettant de tester la foction  getTimeDeb et getTimeFin, qui retourne la date de debut d'une activite sous forme de String
    func testgetTimeDebFin()
    {
        
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        
        // initialisation d une Restaurant ayant lieu le 8eme jour
        let res1 =  Restaurant.insertNewRestaurant(moc, id: 1000, nom: "Domino's Pizza", spec:"Pizza", dateD :"04/07/2016, 11:00", dateF:"01/07/2016, 23:30", adresse: nil , tel: "06 67 79 29 20", photo: "Domino's", rating: "star5")
        
        // verification de l egalite entre "11:00 PM" (correspondant a dateD de res1) et la date de debut de res1
        XCTAssertEqual(res1!.getTimeDeb(),"11:00 AM")
        
        /// verification de l egalite entre "23:30 PM" (correspondant a dateF de res1) et la date de fin de res1
        XCTAssertEqual(res1!.getTimeFin(),"11:30 PM")
        
        // nettoyage de la base apres les test
       Restaurant.deleteData(1000)
        
    }
    
    // test de la fonction qui renvoie tous les restau existants dans la base
    func testGetAccoFetchedResultController()
    {
        let   frc = Restaurant.getRestoFetchedResultController("Restaurant", key: "idRes")
        do {
            try frc.performFetch()
        } catch {
            
            print("An error occured")
        }
        let sections = frc.sections
        let currentSection = sections![0]
        // On en a 11 dans notre base
        XCTAssertEqual( currentSection.numberOfObjects, 11,   "le nombre de jour existant est faux")
        
    }
    
    
    // TEST de la fonction permettant d'avoir le detail d'un hotel
    func testgetDetailAcco() {
        let moc = (UIApplication.sharedApplication().delegate as!AppDelegate).managedObjectContext
        
        let res1 =  Restaurant.insertNewRestaurant(moc, id: 1000, nom: "Domino's Pizza", spec:"Pizza", dateD :"04/07/2016, 11:00", dateF:"01/07/2016, 23:30", adresse: nil , tel: "06 67 79 29 20", photo: "Domino's", rating: "star5")
        
        let frc = Restaurant.getDetailRestoFetchedResultController("Restaurant", key: "idRes", predicat: "idRes=%@", args: (res1?.idRes)!)
        
        do {
            try frc.performFetch()
        } catch {
            
            print("An error occured")
        }
        
        let indexPath = NSIndexPath(forItem: 0, inSection: 0)
        let res = frc.objectAtIndexPath(indexPath)  as! Restaurant
        //  let sections = frc.sections
        //let currentSection = sections![0]
        XCTAssertEqual(res1?.nameRes, res.nameRes, " les noms ne sont pas pareils")
        // nettoyage de la base apres les test
       Restaurant.deleteData(1000)
        
    }
    
    
    
}
