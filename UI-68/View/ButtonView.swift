//
//  ButtonView.swift
//  UI-68
//
//  Created by にゃんにゃん丸 on 2020/12/08.
//

import SwiftUI

struct ButtonView: View {
    
    
    var image : String
    var title : String
    @Binding var selected : String
    
    var black = Color.red.opacity(0.3)
    
    var animation : Namespace.ID
   
    var body: some View {
        Button(action: {
            withAnimation(.spring()){selected = title}
            
        }, label: {
            
            
            HStack{
                
                Image(systemName: image)
                    .font(.title)
                    .frame(width: 25)
                    .foregroundColor(selected == title ? Color.black : black)
                
                Text(title)
                    .fontWeight(selected == title ? .semibold : .none)
                    .foregroundColor(selected == title ? Color.black : black)
                    .animation(.none)
                
                
                    
                Spacer(minLength: 0)
                
                ZStack{
                    
                    
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 3, height: 25)
                    
                    if selected == title{
                        
                        Capsule()
                            .fill(Color.black)
                            .frame(width: 3, height: 25 )
                            .matchedGeometryEffect(id: "tab", in: animation)
                        
                        
                    }
                    
                }
                
                
            }
            .padding(.leading)
        })
        .buttonStyle(PlainButtonStyle())
    }
}

