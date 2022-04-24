//
//  WebKitVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/23.
//

import UIKit
import WebKit

class WebKitVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var link: String!
    
    override func loadView() {
        super.loadView()
                
        webView.uiDelegate = self
        webView.navigationDelegate = self
        //view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        
        let url = URL(string: "https://www.10000recipe.com" + link!)
        let request = URLRequest(url: url!)
        
        self.webView?.allowsBackForwardNavigationGestures = true  //뒤로가기 제스쳐 허용
        //webView.configuration.preferences.javaScriptEnabled = true  //자바스크립트 활성화
        webView.load(request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    } //모달창 닫힐때 앱 종료현상 방지.
}

extension WebKitVC: WKUIDelegate, WKNavigationDelegate {
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //alert 처리
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler() }))
        self.present(alertController, animated: true, completion: nil) }

    //confirm 처리
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "취소", style: .default, handler: { (action) in completionHandler(false) }))
        alertController.addAction(UIAlertAction(title: "확인", style: .default, handler: { (action) in completionHandler(true) }))
        self.present(alertController, animated: true, completion: nil) }
        
    // href="_blank" 처리
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
    // 중복 리로드 방지
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}
