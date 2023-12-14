//
//  CustomTabView.swift
//  PinnedTabDemo
//
//  Created by Harry Kwesi De Graft on 14/12/23.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var tableSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title: String)] = [
    ("house","Home"),
    ("eraser","LifeStyle"),
    ("star","Rewards"),
    ("bell","Notification"),
    ("person","Account"),
    ]
    var body: some View {
        ZStack{
            HStack{
                ForEach(0..<5){
                    index in
                    Button(action: {
                        tableSelection = index + 1
                    }, label: {
                        VStack(spacing: 8){
                            Spacer()
                            
                            Image(systemName: tabBarItems[index].image)
                            
                            Text(tabBarItems[index].title)
                                .font(.caption)
                            
                            if index + 1 == tableSelection{
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(.white)
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                    .offset(y:3)
                            } else {
                                Capsule()
                                .frame(height: 8)
                                .foregroundColor(.clear)
                                .offset(y: 3)
                            }
                        }.foregroundColor(index + 1 == tableSelection ? .red : .gray)
                    })
                }
            }.frame(height: 60)
                .clipShape(BottomCornerRadiusShape(radius: 20))
                .background(Color(red: 20/255, green: 20/255, blue: 20/255))
        }
    }
}

struct BottomCornerRadiusShape: Shape {
    var radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
        path.closeSubpath()

        return path
    }
}

#Preview {
    CustomTabView(tableSelection: .constant(1))
}
