import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var webView: WKWebView!
    
    let initialURL = URL(string: "https://1win-2023-sts.ru")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        webView.load(URLRequest(url: initialURL!))
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Ошибка загрузки \(error.localizedDescription)")
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
                        // Handle the error of a failed cookie creation.
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

//////////////////////////////////////////////////////////////////
//import UIKit
//import WebKit
//
//class WebViewController: UIViewController, UIWebViewDelegate {
//
//    var webView: UIWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        webView = UIWebView(frame: .zero)
//
//        webView.scalesPageToFit = true
//
//        webView.translatesAutoresizingMaskIntoConstraints = false
//
//        view.addSubview(webView)
//
//        setupConstraints()
//
//        webView.delegate = self
//
//        if let savedCookies = UserDefaults.standard.value(forKey: "Cookies") as? [HTTPCookie] {
//            for cookie in savedCookies {
//                HTTPCookieStorage.shared.setCookie(cookie)
//            }
//        }
//
//        let url = URL(string: "https://1weixx.xyz/casino")
//        let request = URLRequest(url: url!, cachePolicy: .reloadIgnoringLocalCacheData)
//        self.webView.loadRequest(request)
//
//    }
//
//    func webViewDidFinishLoad(_ webView: UIWebView) {
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            let savedCookiesData = NSKeyedArchiver.archivedData(withRootObject: cookies)
//            UserDefaults.standard.set(savedCookiesData, forKey: "Cookies")
//            UserDefaults.standard.synchronize()
//        }
//    }
//
//    private func setupConstraints() {
//
//        let safeArea = view.safeAreaLayoutGuide
//        safeArea.owningView?.insetsLayoutMarginsFromSafeArea = true
//
//        NSLayoutConstraint.activate([
//
//            webView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
//            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
//            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
//            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
//
//        ])
//
//    }
//}

