//
//  Speaker.swift
//  Fisu
//
//  Created by Nassim VACHOR on 17/03/2016.
//  Copyright © 2016 Nassim VACHOR. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Speaker: NSManagedObject {


    
    /// methode de classe pour l'insertion d'une nouveau speaker
    /// elle prend en parametre tous les champs de la classe speaker
    /// - returns: speaker inseré si elle existe pas, sinon le speaker même si il existe déja
    class func  insertNewSpeaker( context: NSManagedObjectContext ,id: NSNumber, nom: String, prenom: String, biograp: String, tel: String, photo: String) -> Speaker?{
        let SpeakerDescription = NSEntityDescription.entityForName( "Speaker", inManagedObjectContext : context)
        let request = NSFetchRequest()
        request.entity = SpeakerDescription
        let pred = NSPredicate(format: "(idSpeaker = %@)", id)
        request.predicate = pred
        var speak: Speaker? = nil
        do{
            var result = try context.executeFetchRequest(request)
            // on vérifie que le restau n'existe pas déja dans la base
            
            if result.count == 0 {
                
                
                let newSpeaker = NSEntityDescription.insertNewObjectForEntityForName("Speaker", inManagedObjectContext:context ) as! Speaker
                newSpeaker.idSpeaker = id
                newSpeaker.name = nom
                newSpeaker.surname = prenom
                newSpeaker.biography = biograp
                newSpeaker.phone = tel
                let newImage = UIImage ( named : photo)
                newSpeaker.photoSpe = UIImageJPEGRepresentation(newImage!, 1.0)
                speak = newSpeaker
                do{
                    try context.save()   //newSpeaker.managedObjectContext?.save()
                    print("data saved")
                } catch{
                print("there was an error saving data")
                    
                }
                
            }
            else {
                // pour recuperer l activite qui est deja dans la bd
                let speake = result[0] as! Speaker
                return speake
            }
            
        }
            
        catch {
            print("insertion not done")
            
        }
        
        return speak
        
    }
    
    

    
    
}
