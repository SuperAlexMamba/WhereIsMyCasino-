import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    var domains = ["vk.com" , "ok.ru" , "oauth.yandex.ru" , "mail.ru"]
            
    let lastURLKey = "lastVisitedURLKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.websiteDataStore = WKWebsiteDataStore.default()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.uiDelegate = self
        webView.navigationDelegate = self

        view = webView

        let savedURLString = UserDefaults.standard.string(forKey: lastURLKey)
        let lastURL = savedURLString.flatMap { URL(string: $0) }
        let request = URLRequest(url: lastURL ?? URL(string: "https://1wayrw.xyz/")!)
        webView.load(request)
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let urlString = webView.url?.absoluteString {
            UserDefaults.standard.set(urlString, forKey: lastURLKey)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let cookies = HTTPCookieStorage.shared.cookies
        if let cookies = cookies {
            for cookie in cookies {
                if cookie.domain.contains("ourauthpoint666.com") || cookie.domain.contains("oauth.yandex.ru") || cookie.domain.contains("vk.ru") || cookie.domain.contains("ok.ru") || cookie.domain.contains("tg.ru") || cookie.domain.contains("oauth.yandex.ru") || cookie.domain.contains("steamcommunity.com") {
                    
                    UserDefaults.standard.removeObject(forKey: lastURLKey)
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    print("deleted")
                    
                    let initialURL = URL(string: "https://1wayrw.xyz/")!
                    let request = URLRequest(url: initialURL)
                    
                    print("Cookie Domain - \(cookies.map({ $0.domain })) --------- \n\n\n")
                    print("Cookie Name- \(cookies.map({ $0.name })) ---------- \n\n\n")
                    
                    webView.load(request)
                }
            }
            print("Cookie Domain - \(cookies.map({ $0.domain }))")
            print("Cookie Name- \(cookies.map({ $0.name }))")
        }
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated {
            if let url = navigationAction.request.url {
                webView.load(URLRequest(url: url))
                decisionHandler(.cancel)
                return
            }
        }
        decisionHandler(.allow)
    }
    

    // WKNavigationDelegate methods и другие
}
