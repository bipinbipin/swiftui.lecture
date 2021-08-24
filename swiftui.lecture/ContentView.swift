//
//  ContentView.swift
//  swiftui.lecture
//
//  Created by Aston Developer on 8/11/21.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var serverTime = ""
    
    func loadData() {
        NetworkManager.shared.getData { [self] result in
            // dont know how long this will take...
            DispatchQueue.main.async {
                switch result {
                case .success(let apiResponse):
                    print(apiResponse)
                    self.firstName = apiResponse.firstName
                    self.lastName = apiResponse.lastName
                    self.serverTime = apiResponse.timeStamp
                case .failure(let error):
                    print(error)
                }
            }
        }
        
    }
    
}

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        ZStack {
            
            Color("brandPrimary")
                .ignoresSafeArea()
            
            VStack {
                WelcomeView(brandLogo: "aston-logo")
                
                Button {
                    print("pressed..")
                    viewModel.loadData()
                } label: {
                    ButtonView(title: "Load Data...")
                }
                
                VStack {
                    HStack {
                        Text(viewModel.firstName)
                        Text(viewModel.lastName)
                    }
                    Text(viewModel.serverTime)
                }
                .foregroundColor(.white)
                
                
            }
            
            
            
        }
    }
}

struct ButtonView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 20))
            .foregroundColor(.white)
            .frame(width: 240, height: 40)
            .background(Color("brandSecondary"))
            .cornerRadius(8)
            .padding()
    }
}

struct WelcomeView: View {
    var brandLogo: String
    
    var body: some View {
        Image(brandLogo)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
        
        Text("Welcome Guests!")
            .font(.largeTitle)
            .foregroundColor(.white)
        
        Text("To the first Aston Tech Talk!")
            .font(.title3)
            .foregroundColor(.white)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
