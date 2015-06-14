 import Foundation
 public class Reachability {
    
    //Constant 
    class func isConnectedToCC3200()->Bool{
        
        var Status:Bool = false
        let url = NSURL(string: "http://192.168.1.1")
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "HEAD"
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        request.timeoutInterval = 5.0
        
        var response: NSURLResponse?
    
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
        
        if let httpResponse = response as? NSHTTPURLResponse {
            if httpResponse.statusCode == 200 {
                Status = true
            }
        }
        
        return Status
    }
 }