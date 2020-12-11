import SwiftUI

public typealias NavigationStackItem = Bool
extension NavigationStackItem {
    public init() {
        self = false
    }
}

public class NavigationStack: ObservableObject {
    private var stack: [(Any?, Binding<NavigationStackItem>)] = []
    
    public init() { }
    
    public func push<T>(_ item: Binding<NavigationStackItem>, tag: T) where T : Hashable {
        stack.append((tag, item))
        item.wrappedValue = true
    }
    
    public func push(_ item: Binding<NavigationStackItem>) {
        stack.append((nil, item))
        item.wrappedValue = true
    }
    
    public func pop() {
        stack.popLast()?.1.wrappedValue = false
    }
    
    public func pop<T>(tag: T) where T : Hashable {
        if let stackIndex = stack.firstIndex(where: { ($0.0 as? T) == tag }) {
            stack.removeLast(max(stack.count - (stackIndex + 2), 0))
            self.pop()
        }
    }

    public func popToRoot() {
        stack.first?.1.wrappedValue = false
        stack = []
    }
}
