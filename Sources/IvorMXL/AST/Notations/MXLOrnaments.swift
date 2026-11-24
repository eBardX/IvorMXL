// © 2026 John Gary Pusey (see LICENSE.md)

/// Ornaments can be any of several types, followed optionally by accidentals. The accidental-mark element’s
/// content is represented the same as an accidental element, but with a different name to reflect the different
/// musical meaning.
///
/// One `<ornaments>` element can hold several ornaments, each followed by its own accidental marks — a trill mark
/// and the start of its wavy line, say. Each is one ``Entry``, in document order.
///
/// Maps the MusicXML `<ornaments>` element.
public struct MXLOrnaments {

    // MARK: Public Initializers

    /// Creates a new `MXLOrnaments`.
    ///
    /// - Parameter id:       The optional-unique-id attribute group allows an element to optionally specify an ID that
    ///                       is unique to the entire document. This attribute group is not used for a required id
    ///                       attribute, or for an id attribute that specifies an id reference.
    /// - Parameter entries:  The ornaments, each with the accidental marks that follow it, in document order. Defaults
    ///                       to none.
    public init(id: String? = nil,
                entries: [Entry] = []) {
        self.entries = entries
        self.id = id
    }

    // MARK: Public Instance Properties

    /// The ornaments, each with the accidental marks that follow it, in document order.
    public let entries: [Entry]

    /// The optional-unique-id attribute group allows an element to optionally specify an ID that is unique to the
    /// entire document. This attribute group is not used for a required id attribute, or for an id attribute that
    /// specifies an id reference.
    ///
    /// Maps to the MusicXML `id` attribute.
    public let id: String?
}

// MARK: - Equatable

extension MXLOrnaments: Equatable {
}

// MARK: - Hashable

extension MXLOrnaments: Hashable {
}

// MARK: - Sendable

extension MXLOrnaments: Sendable {
}
