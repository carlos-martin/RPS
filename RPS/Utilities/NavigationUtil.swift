//
//  NavigationUtil.swift
//  RPS
//
//  Created by Carlos Martin on 2023-05-09.
//

import UIKit

struct NavigationUtil {
    static func popToRootView() {
        findNavigationController(viewController: rootViewController())?
            .popToRootViewController(animated: true)
    }

    private static func findNavigationController(viewController: UIViewController?) -> UINavigationController? {
        guard let viewController = viewController else {
            return nil
        }
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }
        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }
        return nil
    }

    private static func rootViewController() -> UIViewController? {
        let window = UIApplication
            .shared
            .connectedScenes
            .flatMap { scene in
                (scene as? UIWindowScene)?.windows ?? []
            }
            .last { window in
                window.isKeyWindow
            }
        return window?.rootViewController
    }
}
