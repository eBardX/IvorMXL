// © 2026 John Gary Pusey (see LICENSE.md)

extension MXLOrnaments {

    // MARK: Public Nested Types

    /// One ornament of an `<ornaments>` element, with the accidental marks that follow it.
    public struct Entry {

        // MARK: Public Initializers

        /// Creates a new `Entry`.
        ///
        /// - Parameter content:          The ornament.
        /// - Parameter accidentalMarks:  The accidentals associated with the ornament, represented the same way as an
        ///                               accidental element but with a different name to reflect the different musical
        ///                               meaning. Defaults to none.
        public init(content: Content,
                    accidentalMarks: [MXLAccidentalMark] = []) {
            self.accidentalMarks = accidentalMarks
            self.content = content
        }

        // MARK: Public Instance Properties

        /// The accidentals associated with the ornament, represented the same way as an accidental element but with
        /// a different name to reflect the different musical meaning.
        ///
        /// Maps to the MusicXML `<accidental-mark>` elements that follow the ornament.
        public let accidentalMarks: [MXLAccidentalMark]

        /// The ornament.
        public let content: Content
    }
}

// MARK: - Equatable

extension MXLOrnaments.Entry: Equatable {
}

// MARK: - Hashable

extension MXLOrnaments.Entry: Hashable {
}

// MARK: - Sendable

extension MXLOrnaments.Entry: Sendable {
}
