//
//  OffsetModifier.swift
//  PinnedTabDemo
//
//  Created by Harry Kwesi De Graft on 14/12/23.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset:CGFloat
    
    var returnFromStart: Bool = true
    @State var startValue : CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay{
                GeometryReader { proxy in
                    Color.clear
                        .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).midY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 0 {
                                startValue = value
                            }
                            offset = (value - (returnFromStart ? startValue : 0 ))
                        }
                }
            }
    }
}

struct OffsetKey : PreferenceKey{
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

//#Preview {
//    OffsetModifier()
//}
