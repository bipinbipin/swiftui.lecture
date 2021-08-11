//
//  ContentView.swift
//  swiftui.lecture
//
//  Created by Aston Developer on 8/11/21.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var serverTime: String = ""
    
    func getData() {
        NetworkManager.shared.getData { [self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let apiResponse):
                    self.firstName = apiResponse.firstName
                    self.lastName = apiResponse.lastName
                    self.serverTime = apiResponse.timeStamp
                    print("success - \(apiResponse)")
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
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                
                Image("aston-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Text("Welcome")
                    .bold()
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                
                Text("Guests")
                    .padding(.bottom, 20)
                
                Button {
                    viewModel.getData()
                    print("button pressed")
                } label: {
                    BrandButton(title: "Answer a question", color: "brandSecondary")
                }
                
                Spacer()
                
                HStack {
                    Text("\(viewModel.firstName)")
                    Text("\(viewModel.lastName)")
                }
                
                Text("\(viewModel.serverTime)")
                
            }
        }
    }
}

struct BrandButton: View {
    var title: String
    var color: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 240, height: 50)
            .background(Color(color))
            .foregroundColor(.white)
            .cornerRadius(8)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
