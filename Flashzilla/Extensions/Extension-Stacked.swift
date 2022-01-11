//
//  Extension-Stacked.swift
//  Flashzilla
//
//  Created by Heath Fashina on 2022-01-10.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset * 10)
    }
}
