The error messages you're seeing in your Xcode project usually indicate specific issues with linking and entry points in your application. Here's what they mean and how you can resolve them:

1. **Undefined symbol: _main :**
   This error suggests that the linker cannot find the entry point of your application, which is typically the `main` function in C/C++ based languages, or the `@main` annotation in a Swift application. In Swift, especially with SwiftUI or UIKit apps, the lack of a main entry can happen if the respective files or annotations are missing or misconfigured.

2. **Linker command failed with exit code 1 (use -v to see invocation) :**
   This is a general linker error that can occur for many reasons including but not limited to the missing entry point mentioned above. It might also indicate other linking issues such as missing frameworks or libraries, or misconfigured build settings.

### Swift Code Changes to Resolve These Issues

To resolve these issues, you likely need to ensure that you have a proper main entry point configured for your Swift application. Below are two scenarios based on whether you are using UIKit or SwiftUI:

#### For a UIKit App:

Make sure you have an AppDelegate file and it's correctly linked in the project settings.

Here's a basic template for `AppDelegate.swift`:

```swift
import UIKit

@UIApplicationMain // This annotation acts as the starting point for the app
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}
```

#### For a SwiftUI App:

Check if you have the `@main` struct properly set up. Here’s how it should look for a minimal SwiftUI application:

```swift
import SwiftUI

@main // This annotation tells the compiler this is the starting point of the app
struct MySwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}
```

### Additional Steps:
- **Check Project Configuration**: Verify that your target's build settings are correct. Make sure that the "Executable" setting is pointing to the right target.
  
- **Re-linking Frameworks**: Sometimes, projects may fail to link properly because frameworks or libraries have not been correctly included. Check under your project's "Build Phases" -> "Link Binary with Libraries" section to ensure everything required is included.

- **Cleaning and Rebuilding**: It can help to clean the build folder (`Shift + Command + K`) and rebuild the project (`Command + B`).

If after trying the suggestions based on the framework your project is using, you’re still seeing the errors, you may need to provide more details such as the content of specific error logs or the configuration of your Info.plist and project settings to diagnose further.