//
//  SceneDelegate.swift
//  Homework6
//
//  Created by Михаил Жданов on 29.11.2020.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        testObservable()
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
    
    private func testObservable() {
        let observable = Observable()
        let observer1 = ObserverA()
        let observer2 = ObserverB()
        observable.add(observer1)
        observable.add(observer2)
        observable.doSomeStuff()
        observable.doSomeStuff()
        observable.remove(observer2)
        observable.doSomeStuff()
    }

}

