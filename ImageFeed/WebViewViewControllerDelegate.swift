//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Всеволод Нагаев on 04.07.2024.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
}
