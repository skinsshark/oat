//
//  ContentView.swift
//  oat
//
//  Created by Sharon Zheng on 2021-01-26.
//

import CoreMotion
import SwiftUI

struct ContentView: View {
    @State var angle: Double = 0.0
    var browser = BrowserView(url:"https://google.com")
    
//    private func getLoadingProgress() -> Double {
//        let progress = browser.getEstimatedProgress()
//        if (progress == 1.0) { return 0.0 }
//        return progress
//    }
    
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
                ProgressView(value: browser.getEstimatedProgress())
                browser
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
