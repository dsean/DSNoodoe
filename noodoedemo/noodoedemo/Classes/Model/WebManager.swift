

import Foundation

class WebManager {
    
    var sessionToken:String = ""
    
    private static var instance:WebManager!
    
    static var sharedManager:WebManager {
        get{
            if instance == nil {
                instance = WebManager()
            }
            return instance
        }
    }
    
    private init(){}
    
    func login(username:String, password:String, completion:@escaping ((_ data:NSDictionary)->Void)) {
        
        var request = URLRequest(url:URL(string:"https://watch-master-staging.herokuapp.com/api/login?username=\(username)&password=\(password)")!)
        request.httpMethod = "GET"
        let client_id = "vqYuKPOkLQLYHhk4QTGsGKFwATT4mBIGREI2m8eD"
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue(client_id, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("", forHTTPHeaderField: "X-Parse-REST-API-Key")
        var json:NSDictionary?;
        let task=URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            if error != nil {
                json = try? ["error":""]
            }
            
            if let safeData = data {
                json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
            }
            completion(json!)
        }
        task.resume()
    }
}
