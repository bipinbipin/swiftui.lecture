//
//  ContentView.swift
//  swiftui.lecture
//
//  Created by Aston Developer on 8/11/21.
//

import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var account_number = ""
    @Published var account_owner = ""
    @Published var username = ""
    @Published var balance = ""
    
    func loadData() {
        NetworkManager.shared.accountNumber = self.account_number
        NetworkManager.shared.getData { [self] result in
            // dont know how long this will take...
            DispatchQueue.main.async {
                switch result {
                case .success(let apiResponse):
                    print(apiResponse)
                    self.account_owner = "Account Owner: \(apiResponse.account_owner)"
                    self.username = "Username: \(apiResponse.username)"
                    let formatter = NumberFormatter()
                    formatter.numberStyle = .currency
                    let bal = formatter.string(from: NSNumber(value: apiResponse.balance))!
                    self.balance = "Balance: \(bal)"
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
                
                Spacer()
                
                HStack {
                    Text("Account Number:")
                    TextField("", text: $viewModel.account_number)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 80)
                        
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
                
                Button {
                    print("pressed..")
                    viewModel.loadData()
                } label: {
                    ButtonView(title: "Account Balance")
                }

                VStack {
                    Text(viewModel.account_owner)
                    Text(viewModel.username)
                    Text(viewModel.balance)
                }
                .font(.title3)
                .foregroundColor(.white)
                
                Spacer()
                
                
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
        
        Text("To the SECOND Aston Tech Talk!")
            .font(.title3)
            .foregroundColor(.white)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
