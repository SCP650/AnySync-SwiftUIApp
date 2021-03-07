//
//  SceneDelegate.swift
//  AnySync
//
//  Created by Atlas on 3/5/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print(URLContexts.first?.url ?? "Print something!!")
        
        if let components = NSURLComponents(url: URLContexts.first!.url, resolvingAgainstBaseURL: true) {
            
            let syncButtonID = components.string?.split(separator: "/").dropFirst().first
            print(syncButtonID!)
            let vm = HomeViewModel()
            vm.loadButtonFromRemote(String(syncButtonID!))
            // handle error here
            let contentView = HomeView(viewModel: vm, isShowingAddView: false)
            // Use a UIHostingController as window root view controller.
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: contentView)
                self.window = window
                window.makeKeyAndVisible()
            }
        }else{
            print("Invalid URL or album path missing")
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let urlContext = connectionOptions.urlContexts.first {
            if let components = NSURLComponents(url: urlContext.url, resolvingAgainstBaseURL: true) {
                
                let syncButtonID = components.string?.split(separator: "/").dropFirst().first
                print(syncButtonID!)
                let vm = HomeViewModel()
                vm.loadButtonFromRemote(String(syncButtonID!))
                // handle error here
                let contentView = HomeView(viewModel: vm, isShowingAddView: false)
                // Create the SwiftUI view and set the context as the value for the managedObjectContext environment keyPath.
                // Add `@Environment(\.managedObjectContext)` in the views that will need the context.
                
                // Use a UIHostingController as window root view controller.
                if let windowScene = scene as? UIWindowScene {
                    let window = UIWindow(windowScene: windowScene)
                    window.rootViewController = UIHostingController(rootView: contentView)
                    self.window = window
                    window.makeKeyAndVisible()
                }
            } else {
                
                let contentView = HomeView()
        
                // Use a UIHostingController as window root view controller.
                if let windowScene = scene as? UIWindowScene {
                    let window = UIWindow(windowScene: windowScene)
                    window.rootViewController = UIHostingController(rootView: contentView)
                    self.window = window
                    window.makeKeyAndVisible()
                }
            }
        } else {

            let contentView = HomeView()
    
            // Use a UIHostingController as window root view controller.
            if let windowScene = scene as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.rootViewController = UIHostingController(rootView: contentView)
                self.window = window
                window.makeKeyAndVisible()
            }

        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

