//
//  coverView.swift
//  um
//
//  Created by riley dou on 2023/1/10.
//

import SwiftUI

struct coverView: View {
    @State private var showMainThing = false
    var body: some View {
        ZStack{
            VStack{
                Image("flower")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
            }
            Button( action: {
                showMainThing = true
            }, label: {
                Label(":)", systemImage: "play.fill")
                    .foregroundColor(.black)
                    .font(.headline)
                    .padding(.vertical, 10)
                    .frame(width: 100, height: 40)
                    .background(.white)
            })
        }.fullScreenCover(isPresented: $showMainThing){
            ContentView()
        }
    }
}

struct coverView_Previews: PreviewProvider {
    static var previews: some View {
        coverView()
    }
}

