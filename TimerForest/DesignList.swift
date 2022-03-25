//
//  DesignList.swift
//  TimerForest
//
//  Created by Никита Мазус on 25.03.2022.
//

import SwiftUI

struct DesignList: View {
    
    @State var timeRemaining: String
    
    var body: some View {
        VStack{
            ZStack(alignment: .leading){
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color("Color"))
                    .frame(width: 300, height: 50)
                    .opacity(0.5)
                VStack(alignment: .leading){
                    Text("\(timeRemaining)")
                        .foregroundColor(.white)
                        .font(.title)
                }
                .padding()
            }
            Rectangle()
                .frame(width: 300, height: 1)
        }
    }
}

struct DesignList_Previews: PreviewProvider {
    static var previews: some View {
        DesignList(timeRemaining: "0.00")
    }
}
