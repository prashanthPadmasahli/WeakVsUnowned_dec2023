//
//  ContentView.swift
//  WeakVsUnowned_dec2023
//
//  Created by mac on 26/12/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Home screen")
                NavigationLink(destination: View2()) {
                    Text("Next")
                }
            }
        }
    }
}

struct View2: View {
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("View2")
            Text(viewModel.name)

            Button("Get Data") {
                //viewModel.fetchData()
            }

            NavigationLink(destination: View3()) {
                Text("Next")
            }
            .onAppear {
                viewModel.fetchData()
            }
        }
    }
}

struct View3: View {
    
    var body: some View {
        VStack {
            Text("View3")
        }
    }
}

class ViewModel: ObservableObject {
    @Published var name = ""
    private let service = WebService()
    
    func fetchData() {
        service.getData(onCompletion: { name1 in
            //guard let self = self else {return}
                self.name = name1
        })
    }
    
    init() {
        print("view model allocated")
    }
    deinit {
        print("view model deallocated")
    }
}


class WebService {
    
    func getData(onCompletion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            onCompletion("Prashanth")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
