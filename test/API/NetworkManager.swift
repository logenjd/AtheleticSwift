//
//  NetworkManager.swift
//  test
//
//  Created by Logeshwaran  on 22/09/23.
//

import UIKit
//import Foundation
class NetworkManager: NSObject {

    static let shared = NetworkManager()
    
 let k_BaseURL = "https://ocs-test-backend.onrender.com/"
 let k_Athletes = "athletes"
 let k_Athlete = "athletes/{id}"
 let k_Games = "games"
 let k_AthletesWithGame = "games/{id}/athletes"
 let k_Photo = "athletes/{id}/photo"
 let k_AthleteDetails = "athletes/{id}/results"
    
    func getAllAthletes(completionHandler: @escaping (_ data:[ModelAthlete], _ error:Error?) -> Void){
        if let url = URL(string: k_BaseURL + k_Athletes){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                  print("Error with fetching films: \(error)")
                    completionHandler([], error)
                  return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                  return
                }
                if let data = data{
                    let jsonDecoder = JSONDecoder()
                    do
                    {
                        let responseModel = try jsonDecoder.decode([ModelAthlete].self, from: data)
                        completionHandler(responseModel, error)
                        print("Success")
                    } catch let error as NSError
                    {
                        print("fail")
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getAthleteWith(id:String , completionHandler: @escaping (_ data:ModelAthlete, _ error:Error?) -> Void){
        if let url = URL(string: k_BaseURL + k_Athlete.replacingOccurrences(of: "{id}", with: id)){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                  print("Error with fetching films: \(error)")
                  return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                  return
                }
                if let data = data{
                    let jsonDecoder = JSONDecoder()
                    do
                    {
                        let responseModel = try jsonDecoder.decode(ModelAthlete.self, from: data)
                        completionHandler(responseModel, error)
                        print("Success")
                        
                    } catch let error as NSError
                    {
                        print("fail")
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    
        func getAllGames(completionHandler: @escaping (_ data:[ModelGame], _ error:Error?) -> Void){
            if let url = URL(string: k_BaseURL + k_Games){
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                      print("Error with fetching films: \(error)")
                      return
                    }
                    guard let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) else {
                        print("Error with the response, unexpected status code: \(String(describing: response))")
                      return
                    }
                    if let data = data{
                        let jsonDecoder = JSONDecoder()
                        do
                        {
                            let responseModel = try jsonDecoder.decode([ModelGame].self, from: data)
                            completionHandler(responseModel, error)
                            print("Success")
                            
                        } catch let error as NSError
                        {
                            print("fail")
                            print(error)
                        }
                    }
                }
                task.resume()
            }
        }
    
    
    func getAthletesWithGame(id:String, game:ModelGame, completionHandler: @escaping (_ data:[ModelAthlete],_ game:ModelGame, _ error:Error?) -> Void){
        if let url = URL(string: k_BaseURL + k_AthletesWithGame.replacingOccurrences(of: "{id}", with: id)){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                  print("Error with fetching films: \(error)")
                  return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                  return
                }
                if let data = data{
                    let jsonDecoder = JSONDecoder()
                    do
                    {
                        let responseModel = try jsonDecoder.decode([ModelAthlete].self, from: data)
                        game.athletesList?.removeAll()
                        game.athletesList = responseModel
                        completionHandler(responseModel,game,error)
                        print("Success")
                        
                    } catch let error as NSError
                    {
                        print("fail")
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    
    func getAthleteMedalDetailsWith(id:String, completionHandler: @escaping (_ data:[ModelMedalDetails], _ error:Error?) -> Void){
        if let url = URL(string: k_BaseURL + k_AthleteDetails.replacingOccurrences(of: "{id}", with: id)){
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                  print("Error with fetching films: \(error)")
                  return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                  return
                }
                if let data = data{
                    let jsonDecoder = JSONDecoder()
                    do
                    {
                        let responseModel = try jsonDecoder.decode([ModelMedalDetails].self, from: data)
                        completionHandler(responseModel,error)
                        print("Success")
                        
                    } catch let error as NSError
                    {
                        print("fail")
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
    
}
