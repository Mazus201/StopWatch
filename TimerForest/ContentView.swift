//
//  ContentView.swift
//  TimerForest
//
//  Created by Никита Мазус on 24.03.2022.
//

import SwiftUI

struct Data: Identifiable {
    let id = UUID()
    var time: String
}

struct ContentView: View {
    
    @State var timeRemaining = 0.0 //передается в поле text. Float со временем
    @State var starTimer = false //запущен ли таймер
    @State var stopTimes: [String] = [] //массив с кругами
    @State var pitStop = 0 //количесвто кругов (и место в массиве)
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() //сам таймер (нашел в интернете)
    
    private let values: [Data] = [
        Data(time: "0.00")
    ]
    
    var body: some View {
        ZStack{
            Image("ForrestGump")
                .ignoresSafeArea()
            Color("Color")
                .ignoresSafeArea()
                .opacity(0.6)
            VStack{
                Spacer()
                Text(String(format: "%.2f", timeRemaining)) //поле, где отображается время с двумя знаками после запятой
                    .onReceive(timer) { _ in
                        if (timeRemaining >= 0 && starTimer == true) {
                            timeRemaining += 0.01 //каждую 0.1 секунду добавляем 0.1
                        }
                    }
                    .frame(width: 200, height: 50)
                    .font(.system(size: 30))
                    .padding(.bottom)
                    .foregroundColor(.white)
                    
                VStack{
                    HStack{
                        Button(action: {
                            if (starTimer == false && timeRemaining != 0.0) {
                                timeRemaining = 0.0
                                starTimer = false
                                pitStop = 0
                                stopTimes = []
                            }
                            else{
                                if (pitStop >=  0 && starTimer == true) {
                                    stopTimes.append(String(format: "%.2f", timeRemaining)) //записываем в массив на место курга значение из таймера
                                    pitStop += 1 //добавляем в стопы + 1, чтобы потом на это место записать новый круг
                                }
                            }
                        })
                        {
                            if (starTimer == false && timeRemaining != 0.0) {
                                HStack{
                                    Image(systemName: "memories")
                                        .foregroundColor(.white)
                                    Text("Reset")
                                        .padding(.trailing, 50)
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                HStack{
                                    Image(systemName: "goforward")
                                        .foregroundColor(.white)
                                    Text("Lap")
                                        .padding(.trailing, 50)
                                        .foregroundColor(.white)
                                }
                                
                            }
                        }
                        Button(action: {
                            starTimer.toggle() //включаем таймер
                        }){
                            if starTimer == true {
                                HStack{
                                    Image(systemName: "pause.fill")
                                        .foregroundColor(.white)
                                    Text("Pause")
                                        .foregroundColor(.white)
                                }
                            }
                            else {
                                Text("▶︎ Play")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                }
                Spacer()
                Spacer()
            }
            ScrollView(showsIndicators: false){
                VStack(spacing: 15) {
                    ForEach(stopTimes, id: \.self) { //перебираем массив и отображаем значение в списке
                        stopTime in Text(stopTime)
                        if pitStop != 0 {
                            Rectangle()
                                .fill(.black)
                                .frame(width: 300, height: 1)
                                .opacity(0.5)
                        }
                    }
                    Spacer()
                }
//                .frame(width: 300, height: 500)
                .foregroundColor(.white)
                .font(.system(size: 20))
            }
            .frame(width: 300, height: 500)
            .offset(y: 200)
        }
    }
}
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
