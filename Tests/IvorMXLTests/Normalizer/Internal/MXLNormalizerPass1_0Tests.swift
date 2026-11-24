// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLNormalizerPass1_0Tests {    // swiftlint:disable:this type_name
}

// MARK: -

extension MXLNormalizerPass1_0Tests {
    @Test
    func apply_leavesScoreWithoutStaffSpacingUnchanged() throws {
        let score = try partwise("minimal-partwise.musicxml")

        let (edited, changes) = MXLNormalizer.Pass1_0().apply(to: score)

        #expect(changes.isEmpty)
        #expect(edited == score)
    }

    @Test
    func apply_movesStaffSpacingToStaffLayout() throws {
        let score = try partwise("print-staff-spacing.musicxml")

        let (edited, changes) = MXLNormalizer.Pass1_0().apply(to: score)

        #expect(changes.contains(.replacedConstruct("print/@staff-spacing", "staff-layout/staff-distance")))
        let prints = edited.parts.flatMap(\.measures).flatMap(\.items).compactMap { item -> MXLPrint? in
            guard case let .print(print) = item
            else { return nil }

            return print
        }

        #expect(!prints.isEmpty)
        #expect(prints.allSatisfy { $0.attributes.staffSpacing == nil })
    }
}
