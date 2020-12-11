//
//  ContentView.swift
//  SwiftUI
//
//  Created by Alessandro Mulloni on 10.12.20.
//

import SwiftUI
import SwiftUI_NavigationStack

struct ContentViewRoot: View {
    let navigationStack = NavigationStack()
    @State var presentingFirst = NavigationStackItem()

    var body: some View {
        NavigationView{
            ZStack {
                Color.red.opacity(0.2).edgesIgnoringSafeArea(.all)
                VStack{
                    NavigationLink(destination: ContentViewFirst(), isActive: self.$presentingFirst) { EmptyView() }
                    Button("Push") { self.navigationStack.push(self.$presentingFirst, tag: "ContentViewFirst") }
                }
                .navigationBarTitle("Root")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(navigationStack)
    }
}

struct ContentViewFirst: View {
    @EnvironmentObject var navigationStack: NavigationStack
    @State var presentingSecond = NavigationStackItem()

    var body: some View {
        ZStack {
            Color.green.opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack{
                NavigationLink(destination: ContentViewSecond(), isActive: self.$presentingSecond) { EmptyView() }

                Spacer()
                Button("Push") { self.navigationStack.push(self.$presentingSecond) }
                Spacer()
                Button("Pop") { self.navigationStack.pop() }
                Spacer()
            }
        }
        .navigationBarTitle("1st")
    }
}

struct ContentViewSecond: View {
    @EnvironmentObject var navigationStack: NavigationStack
    @State var presentingA = NavigationStackItem()
    @State var presentingB = NavigationStackItem()

    var body: some View {
        ZStack {
            Color.blue.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationLink(destination: ContentViewThirdA(), isActive: self.$presentingA) { EmptyView() }
                NavigationLink(destination: ContentViewThirdB(), isActive: self.$presentingB) { EmptyView() }

                Spacer()
                Button("Push A") { self.navigationStack.push(self.$presentingA) }
                Spacer()
                Button("Push B") { self.navigationStack.push(self.$presentingB) }
                Spacer()
                Button("Pop") { self.navigationStack.pop() }
                Spacer()
            }
        }
        .navigationBarTitle("2nd")
    }
}

struct ContentViewThirdA: View {
    @EnvironmentObject var navigationStack: NavigationStack
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Button("Pop") { self.navigationStack.pop() }
                Spacer()
                Button("Pop to first") { self.navigationStack.pop(tag: "ContentViewFirst") }
                Spacer()
                Button("PopToRoot") { self.navigationStack.popToRoot() }
                Spacer()
            }
        }
        .navigationBarTitle("3rd A")
    }
}

struct ContentViewThirdB: View {
    @EnvironmentObject var navigationStack: NavigationStack
    
    var body: some View {
        ZStack {
            Color.yellow.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                Button("Pop") { self.navigationStack.pop() }
                Spacer()
                Button("Pop to first") { self.navigationStack.pop(tag: "ContentViewFirst") }
                Spacer()
                Button("PopToRoot") { self.navigationStack.popToRoot() }
                Spacer()
            }
        }
        .navigationBarTitle("3rd B")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewRoot()
        ContentViewFirst()
        ContentViewSecond()
        ContentViewThirdA()
        ContentViewThirdB()
    }
}
