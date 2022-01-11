//
//  withOptionalAnimation.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-09.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}
