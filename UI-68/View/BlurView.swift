//
//  BlurView.swift
//  UI-68
//
//  Created by にゃんにゃん丸 on 2020/12/08.
//

import SwiftUI

struct BlurView: NSViewRepresentable {
    
    func makeNSView(context: Context) -> NSVisualEffectView {
        let view = NSVisualEffectView()
        view.blendingMode = .behindWindow
        return view
    }
    
    func updateNSView(_ nsView: NSVisualEffectView, context: Context) {
        
    }
    
}


