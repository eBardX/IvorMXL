// © 2026 John Gary Pusey (see LICENSE.md)

extension MXLKey {

    /// One of the alternatives for Key.
    public enum Content {
        /// A non-traditional key signature: a sequence of non-traditional-key groups, each a single
        /// alteration, in the order they appear.
        case nonTraditionalKey([MXLNonTraditionalKey])

        /// The traditional-key group represents a traditional key signature using the cycle of fifths.
        case traditionalKey(MXLTraditionalKey)
    }
}

// MARK: - Equatable

extension MXLKey.Content: Equatable {
}

// MARK: - Hashable

extension MXLKey.Content: Hashable {
}

// MARK: - Sendable

extension MXLKey.Content: Sendable {
}
