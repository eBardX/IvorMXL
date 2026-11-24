// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLNormalizerPass3_1Tests {    // swiftlint:disable:this type_name
}

// MARK: -

extension MXLNormalizerPass3_1Tests {
    @Test
    func apply_leavesCurrentScoreUnchanged() throws {
        let score = try partwise("minimal-partwise.musicxml")

        let (edited, changes) = MXLNormalizer.Pass3_1().apply(to: score)

        #expect(changes.isEmpty)
        #expect(edited == score)
    }

    @Test
    func apply_replacesFunctionWithNumeral() throws {
        let score = try partwise("harmony-function.musicxml")

        let (_, changes) = MXLNormalizer.Pass3_1().apply(to: score)

        #expect(changes.contains(.replacedConstruct("harmony/function", "harmony/numeral")))
    }

    @Test
    func apply_replacesNoneSign() throws {
        let score = try partwise("clef-sign-none.musicxml")

        let (_, changes) = MXLNormalizer.Pass3_1().apply(to: score)

        #expect(changes.contains(.replacedConstruct("clef/sign[none]", "clef/@print-object")))
    }
}
