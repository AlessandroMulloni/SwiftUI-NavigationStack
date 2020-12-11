# SwiftUI-NavigationStack

A very minimalistic navigation stack for SwiftUI NavigationView with push/pop operations and optional tags. It is meant to simplify the usage of NavigationView and NavigationLink.

# NavigationStack

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. Open Xcode, click on `File -> Swift Packages -> Add Package dependency...` and use the repository URL (https://github.com/AlessandroMulloni/SwiftUI-NavigationStack) to download the package.

In XCode, when prompted for Version or branch, the suggestion is to use Branch: master.

## Objects

### NavigationStack

Implements the stack and offers push and pop operations.

### NavigationItem

A simple wrapper around Bool with a default initializer to ``false``.

## Usage

Include `SwiftUI_NavigationStack` and **inject the NavigationStack** into your NavigationView as an environment object.

```
import SwiftUI_NavigationStack

struct RootView: View {
    let navigationStack = NavigationStack()

    var body: some View {
        NavigationView{
            ...
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(navigationStack)
    }
```

**Push** any desired view by defining a standard NavigationLink and then pushing the corresponding binding to the stack.

```
import SwiftUI_NavigationStack

struct RootView: View {
    @State var presentingChild = NavigationStackItem()
    ...

    var body: some View {
        NavigationView{
            NavigationLink(destination: ChildView(), isActive: self.$presentingChild) { EmptyView() }
            Button("Push") { 
                self.navigationStack.push(self.$presentingChild) 
            }
        }
    }
}
```

Optionally, add a tag to the view you pushed (any Hashable will work).

```
...
Button("Push") { 
    self.navigationStack.push(self.$presentingFirst, tag: "MyTag") 
}
...
```

When you are done with the view, you can **pop** it from the stack.

```
import SwiftUI_NavigationStack

struct ChildView: View {
    @EnvironmentObject var navigationStack: NavigationStack

    var body: some View {
        Button("Pop") { 
            self.navigationStack.pop() 
        }
    }
}
```

Optionally, you can pop all views to a specific view.

```
...
Button("Pop") { 
    self.navigationStack.pop(tag: "MyTag) 
}
...
```

Or you can pop all views to the root.

```
...
Button("Pop") { 
    self.navigationStack.popToRoot() 
}
...
```

## Caveats

This library is based on the assumption that all stack operations are performed on the NavigationStack. Of course setting

```
...
self.$presentingChild = false
...
```

will pop the corresponding view but the NavigationStack will not match the status of the app anymore.
