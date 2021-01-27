//
//  BrowserView.swift
//  oat
//
//  Created by SZ on 2021-01-26.
//

import SwiftUI
import WebKit

struct BrowserView: UIViewRepresentable {
    @State var url: String
    let wkWebView = WKWebView()
    
    func getEstimatedProgress() -> Double {
        return wkWebView.estimatedProgress
    }
    
    func makeUIView(context: UIViewRepresentableContext<BrowserView>) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        
        wkWebView.load(request)
        wkWebView.allowsBackForwardNavigationGestures = true
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<BrowserView>) {}
}
