// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLNormalizerPass1_1Tests {    // swiftlint:disable:this type_name
}

// MARK: -

extension MXLNormalizerPass1_1Tests {
    @Test
    func apply_leavesScoreWithoutDeprecatedFormattingUnchanged() throws {
        let score = try partwise("minimal-partwise.musicxml")

        let (edited, changes) = MXLNormalizer.Pass1_1().apply(to: score)

        #expect(changes.isEmpty)
        #expect(edited == score)
    }

    @Test
    func apply_movesGroupNameFormattingToDisplay() throws {
        let score = try partwise("group-name-formatting.musicxml")

        let (_, changes) = MXLNormalizer.Pass1_1().apply(to: score)

        #expect(changes.contains(.replacedConstruct("group-name/@font-size", "group-name-display/display-text")))
    }

    @Test
    func apply_movesPartNameFormattingToDisplay() throws {
        let score = try partwise("part-name-formatting.musicxml")

        let (_, changes) = MXLNormalizer.Pass1_1().apply(to: score)

        #expect(changes.contains(.replacedConstruct("part-name/@font-size", "part-name-display/display-text")))
    }

    @Test
    func apply_movesSoundPanToMidiInstrument() throws {
        let score = try partwise("sound-pan-elevation.musicxml")

        let (_, changes) = MXLNormalizer.Pass1_1().apply(to: score)

        #expect(changes.contains(.replacedConstruct("sound/@pan", "midi-instrument/pan")))
    }
}
