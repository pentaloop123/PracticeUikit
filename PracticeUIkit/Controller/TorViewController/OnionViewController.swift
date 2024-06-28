

//import UIKit
//import OnionBrowserCore
//
//class OnionViewController: UIViewController {
//    var torClient: TorClient!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Initialize TorClient
//        torClient = TorClient.shared
//        torClient.configureSocks(username: nil, password: nil)
//        
//        // Start Tor
//        torClient.start {
//            print("Tor has started")
//            self.makeTorRequest()
//        }
//    }
//
//    func makeTorRequest() {
//        // Create a URLSessionConfiguration with the Tor proxy settings
//        let configuration = URLSessionConfiguration.ephemeral
//        configuration.connectionProxyDictionary = [
//            kCFProxyTypeKey as String: kCFProxyTypeSOCKS as String,
//            kCFStreamPropertySOCKSProxyHost as String: "127.0.0.1",
//            kCFStreamPropertySOCKSProxyPort as String: 9050
//        ]
//
//        let session = URLSession(configuration: configuration)
//        let url = URL(string: "http://check.torproject.org")!
//
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//
//            if let data = data, let responseString = String(data: data, encoding: .utf8) {
//                print("Response: \(responseString)")
//            }
//        }
//
//        task.resume()
//    }
//}
