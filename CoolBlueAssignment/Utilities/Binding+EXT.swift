//
//  Binding+EXT.swift
//  CoolBlueAssignment
//
//  Created by Tran Gia Huy on 7/14/25.
//

import SwiftUI

extension Binding where Value == Bool {
	init<T: Sendable>(ifNotNil value: Binding<T?>) {
		self.init {
			value.wrappedValue != nil
		} set: { newValue in
			if !newValue {
				value.wrappedValue = nil
			}
		}
	}
}
