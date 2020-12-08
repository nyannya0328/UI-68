//
//  Home.swift
//  UI-68
//
//  Created by にゃんにゃん丸 on 2020/12/08.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    var window = NSScreen.main?.visibleFrame
    
    @State var txt = ""
    
    var columuns = Array(repeating:GridItem(.flexible(),spacing:15),count:4)
    
    @StateObject var imagedata = ImageViewModel()
    
    var body: some View {
        HStack{
            
            SideBar()
            
            VStack{
                
                
                HStack(spacing:12){
                    
                    Image(systemName: "magnifyingglass.circle.fill")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $txt)
                        .textFieldStyle(PlainTextFieldStyle())
                        
                        
                        
                        
                        .padding(.horizontal)
                        .padding(.vertical,10)
                        .background(BlurView())
                        .cornerRadius(10)
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "slider.vertical.3")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.black)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(10)
                        
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.top,10)
                
                
                Spacer()
                
                
                
                
                
                GeometryReader { reader in
                    ScrollView{
                        
                        
                        LazyVGrid(columns: columuns,spacing : 20){
                            
                            ForEach(imagedata.images.indices,id:\.self){index in
                                
                                ZStack {
                                    WebImage(url: URL(string: imagedata.images[index].download_url)!)
                                        .placeholder {
                                            ProgressView()
                                        }
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: (reader.frame(in: .global).width - 45) / 4, height: 250)
                                        .cornerRadius(15)
                                    
                                    Color.black.opacity(imagedata.images[index].onHover ?? false ? 0.2 : 0)
                                    
                                    VStack{
                                        
                                        
                                        HStack{
                                            
                                            Spacer(minLength: 0)
                                            
                                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                                Image(systemName: "hand.thumbsup.fill")
                                                    .foregroundColor(.green)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .cornerRadius(20)
                                                
                                            })
                                            .buttonStyle(PlainButtonStyle())
                                            
                                            
                                            Button(action: {saveimages(index: index)}, label: {
                                                Image(systemName: "folder.fill")
                                                    .foregroundColor(.blue)
                                                    .padding(8)
                                                    .background(Color.white)
                                                    .cornerRadius(20)
                                                
                                            })
                                            .buttonStyle(PlainButtonStyle())
                                            
                                        }
                                        .padding(10)
                                        Spacer()
                                    }
                                    .opacity(imagedata.images[index].onHover ?? false ?  1 : 0)
                                    
                                    
                                }
                                .onHover(perform: { hovering in
                                    imagedata.images[index].onHover = hovering
                                })
                                
                                
                                
                            }
                            
                        }
                    }
                }
                
            }
            
        }
        
        .ignoresSafeArea(.all, edges: .all)
        .frame(width: window!.width / 1.5, height: window!.height - 40)
        .background(Color.white.opacity(0.6))
        .background(BlurView())
        
    }
    
    func saveimages(index:Int){
        
        let manager = SDWebImageDownloader(config: .default)
        manager.downloadImage(with: URL(string: imagedata.images[index].download_url)!) { (image, _, _, _) in
            guard let imageoriginal = image else{return}
            
            let data = imageoriginal.sd_imageData(as: .JPEG)
            let panel = NSSavePanel()
            
            
            panel.canCreateDirectories = true
            panel.nameFieldStringValue = "\(imagedata.images[index].id).jpeg"
            panel.begin { (responce) in
                if responce.rawValue == NSApplication.ModalResponse.OK.rawValue{
                    do{
                        
                        try data?.write(to: panel.url!,options: .atomicWrite)
                        print("Success")
                        
                        
                    }catch
                    
                    
                    {print(error.localizedDescription)}
                    
                    
                }
            }
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct SideBar: View {
    
    @State var selected = "Home"
    
    @Namespace var animation
    var body: some View {
        
        
        HStack{
            
            VStack{
                
                Group{
                    
                    
                    HStack{
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                        Text("2020")
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        
                        
                        
                        Spacer(minLength: 0)
                        
                        
                        
                        
                    }
                    .padding(.top,35)
                    .padding(.leading,10)
                    
                    ButtonView(image: "house.fill", title: "Home", selected: $selected, animation: animation)
                    
                    ButtonView(image: "clock.fill", title: "Recents", selected: $selected, animation: animation)
                    
                    ButtonView(image: "person.2.fill", title: "Following", selected: $selected, animation: animation)
                    
                    HStack{
                        
                        
                        
                        Text("Insight")
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                        
                        Spacer(minLength: 0)
                    }
                    .padding()
                    
                    ButtonView(image: "message.fill", title: "Message", selected: $selected, animation: animation)
                    
                    ButtonView(image: "bell.fill", title: "Notification", selected: $selected, animation: animation)
                }
                
                
                VStack(spacing:5){
                    
                    Image("c1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("May I happy to you")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("Thank you")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    
                    Image("c")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    
                    
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Cat With Chair")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Text("にゃん。\nなんかようにゃん？")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    
                    
                    
                    
                    
                }
                .padding(.top,150)
                
                Spacer(minLength: 0)
                
                
                HStack(spacing:10){
                    
                    
                    Image("pro")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    
                    VStack(alignment:.leading,spacing:8){
                        
                        
                        Text("Dog Man")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        
                        Text("Last Login Tue/8/12/2020")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        
                        
                    }
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.right")
                    
                    
                }
                .padding(.horizontal,10)
                .padding(.vertical,10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: -5, y: -5)
                .padding(.horizontal,20)
                .padding(.bottom,20)
                
                
                
                
                
            }
            
            Divider()
                .offset(x: -2)
            
        }
        
        
        .frame(width: 240)
    }
}


extension NSTextField{
    
    open override var focusRingType: NSFocusRingType{
        
        get{.none}
        set{}
        
    }
    
}
