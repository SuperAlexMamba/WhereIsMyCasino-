import UIKit
import WebKit

class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    
    let lastURLKey = "lastVisitedURLKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.websiteDataStore = WKWebsiteDataStore.default()
        
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.allowsBackForwardNavigationGestures = true
        webView.configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        view.addSubview(webView)
        
        
        let safeArea = view.safeAreaLayoutGuide
        safeArea.owningView?.insetsLayoutMarginsFromSafeArea = true
        
        NSLayoutConstraint.activate([
            
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0),
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 0),
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0)
            
        ])
        
        let savedURLString = UserDefaults.standard.string(forKey: lastURLKey)
        let lastURL = savedURLString.flatMap { URL(string: $0) }
        let request = URLRequest(url: lastURL ?? URL(string: "https://slotozalcash.com/")!)
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
                if cookie.domain.contains("ourauthpoint666.com") || cookie.domain.contains("oauth.yandex.ru") || cookie.domain.contains("vk.ru") || cookie.domain.contains("ok.ru") || cookie.domain.contains("tg.ru") || cookie.domain.contains("oauth.yandex.ru") || cookie.domain.contains("steamcommunity.com") || cookie.domain.contains("login4play.com") {
                    
                    UserDefaults.standard.removeObject(forKey: lastURLKey)
                    HTTPCookieStorage.shared.deleteCookie(cookie)
                    print("deleted")
                    
                    let initialURL = URL(string: "https://slotozalcash.com/")!
                    let request = URLRequest(url: initialURL)
                    
                    print("Cookie Domain - \(cookies.map({ $0.domain })) --------- \n\n\n")
                    print("Cookie Name- \(cookies.map({ $0.name })) ---------- \n\n\n")
                    
                    webView.load(request)
                }
            }
            print("Cookie Domain - \(cookies.map({ $0.domain })) --------- \n\n\n")
            print("Cookie Name- \(cookies.map({ $0.name })) --------- \n\n\n")
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
}
