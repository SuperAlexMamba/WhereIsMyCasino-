import UIKit
import WebKit

class AdLoadController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Orientation.lockOrientation([.portrait , .landscapeRight , .landscapeLeft])
        
        adLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.websiteDataStore = WKWebsiteDataStore.default()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsLinkPreview = true
        webView.allowsBackForwardNavigationGestures = true
        
        view.addSubview(webView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
        func adLoad() {
            
            var request = URLRequest(url: URL(string: decodeKey())!)
            
            request.httpMethod = "GET"
            
            request.setValue("$2a$10$HvkZCNpxNwJWLfPxz.U4Vux77uLjfXnUDMXAaAZTfhtGNfkUt/082", forHTTPHeaderField: "X-MASTER-KEY")
            
            request.setValue(keey+keeey, forHTTPHeaderField: "X-ACCESS-KEY")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else { return }
                let adKey = try? JSONDecoder().decode(Ad.self, from: data)
                initialURL = URL(string: (adKey?.record.url)!)
            }
            task.resume()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.webView.load(URLRequest(url: initialURL!))
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(error.localizedDescription)")
    }
    

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
               
        guard let url = initialURL else {
            decisionHandler(.cancel)
            return
        }
        
        webView.loadDiskCookies(for: url.host!) {
            decisionHandler(.allow)
        }
    }
    

    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = initialURL else {
            decisionHandler(.cancel)
            return
        }
        
        webView.writeDiskCookies(for: url.host!){
            decisionHandler(.allow)
        }
    }
     
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if let frame = navigationAction.targetFrame,
           frame.isMainFrame {
            return nil
        }
        webView.load(navigationAction.request)
        return nil
    }

}

public extension URL {
 
 func isTelegram() -> Bool {
    return ((self.host?.contains("telegram.me") == true) || (self.host?.contains("t.me") == true))
 }
}

extension WKWebView {
    
    enum PrefKey {
        static let cookie = "cookies"
    }
    
    func writeDiskCookies(for domain: String, completion: @escaping () -> Void) {
        fetchInMemoryCookies(for: domain) { data in
            print("write data", data)
            UserDefaults.standard.set(data, forKey: PrefKey.cookie + domain)
            completion()
        }
    }
    
    func loadDiskCookies(for domain: String, completion: @escaping () -> Void) {
        if let diskCookies = UserDefaults.standard.object(forKey: PrefKey.cookie + domain) as? [String: [HTTPCookiePropertyKey: Any]] {
            
            fetchInMemoryCookies(for: domain) { freshCookies in
                let mergedCookies = diskCookies.merging(freshCookies, uniquingKeysWith: { (_, new) in new })
                
                let cookiesGroup = DispatchGroup()
                
                for (_, cookieProperties) in mergedCookies {
                    cookiesGroup.enter()
                    if let cookie = HTTPCookie(properties: cookieProperties) {
                        self.configuration.websiteDataStore.httpCookieStore.setCookie(cookie) {
                            cookiesGroup.leave()
                        }
                    } else {
                        
                        print("Error creating cookie from properties: \(cookieProperties)")
                        cookiesGroup.leave()
                    }
                }
                
                cookiesGroup.notify(queue: .main) {
                    completion()
                }
            }
        } else {
            completion()
        }
    }
    
    func fetchInMemoryCookies(for domain: String, completion: @escaping ([String: [HTTPCookiePropertyKey: Any]]) -> Void) {
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies { (cookies) in
            var cookieDict: [String: [HTTPCookiePropertyKey: Any]] = [:]
            for cookie in cookies where cookie.domain.contains(domain) {
                cookieDict[cookie.name] = cookie.properties
            }
            completion(cookieDict)
        }
    }
}
