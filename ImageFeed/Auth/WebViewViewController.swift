
import UIKit
import WebKit

final class WebViewViewController: UIViewController {
    
    @IBOutlet private var webView: WKWebView!
    @IBAction private func didTapBackButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        
 /*  var urlComponents = URLComponents(string: UnsplashAuthorizeURLString)!
    urlComponents.queryItems = [
       URLQueryItem(name: "client_id", value: AccessKey),
       URLQueryItem(name: "redirect_uri", value: RedirectURI),
       URLQueryItem(name: "response_type", value: "code"),
       URLQueryItem(name: "scope", value: AccessScope)
     ]
     let url = urlComponents.url!
    
        let request = URLRequest(url: url)
        webView.load(request)
        
        webView.navigationDelegate = self
}
    
}

extension WebViewViewController: WKNavigationDelegate {
    
    func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
         if let code = code(from: navigationAction) {
                //TODO: process code
                decisionHandler(.cancel) //3
          } else {
                decisionHandler(.allow) //4
            }
    }
    
    private func code(from navigationAction: WKNavigationAction) -> String? {
        if
            let url = navigationAction.request.url,
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == "/oauth/authorize/native",
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == "code" })
        {
            return codeItem.value                                           
        } else {
            return nil
        }*/
    }
}
