//
//  ContentView.swift
//  oat
//
//  Created by Sharon Zheng on 2021-01-26.
//

import CoreMotion
import SwiftUI
import SafariServices
import WebKit

struct ContentView: View {
    @State var angle: Double = 0.0
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Text("👀")
                Text("Hey, eyes up here")
                Spacer()
                Spacer()
            }
            VStack {
                Internet(url:"https://google.com")
                    .rotation3DEffect(
                        Angle(degrees: angle),
                        axis: (x: 1.0, y: 0.0, z: 0.0)
                    )
                    .offset(x: 0, y: CGFloat(angle*8))
            }.onAppear(perform: startGyroUpdates)
        }
    }
    
    let motionManager = CMMotionManager()
    
    func startGyroUpdates() {
        if motionManager.isDeviceMotionAvailable {
//            motionManager.deviceMotionUpdateInterval = 0.5
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, err) in
                DispatchQueue.main.async {
                    if let attitude = data?.attitude {
                        let reading: Double = 90 - (attitude.pitch * 180 / Double.pi)
                        self.angle = reading < 35 ? 0 : reading - 30
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Internet: UIViewRepresentable {
    @State var url: String
    func makeUIView(context: UIViewRepresentableContext<Internet>) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        wkWebView.allowsBackForwardNavigationGestures = true
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<Internet>) {}
}
