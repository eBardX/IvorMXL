// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLOrnamentsTests {
}

// MARK: -

extension MXLOrnamentsTests {
    @Test
    func equality() {
        let entry = MXLOrnaments.Entry(content: .trillMark(MXLEmptyTrillSound()))

        #expect(MXLOrnaments(entries: [entry]) == MXLOrnaments(entries: [entry]))    // swiftlint:disable:this identical_operands
    }

    @Test
    func hashable() {
        let entry = MXLOrnaments.Entry(content: .trillMark(MXLEmptyTrillSound()))
        let values: Set<MXLOrnaments> = [MXLOrnaments(entries: [entry]),
                                         MXLOrnaments(entries: [entry]),
                                         MXLOrnaments(id: "o2", entries: [entry])]

        #expect(values.count == 2)
    }

    @Test
    func inequality() {
        let entry = MXLOrnaments.Entry(content: .trillMark(MXLEmptyTrillSound()))

        #expect(MXLOrnaments(entries: [entry]) != MXLOrnaments(id: "o2", entries: [entry]))
        #expect(MXLOrnaments(entries: [entry]) != MXLOrnaments(entries: [entry, entry]))
    }

    @Test
    func init_defaultValues() {
        let value = MXLOrnaments()

        #expect(value.entries.isEmpty)
        #expect(value.id == nil)
    }

    @Test
    func init_explicitValues() {
        let entries = [MXLOrnaments.Entry(content: .trillMark(MXLEmptyTrillSound()),
                                          accidentalMarks: [MXLAccidentalMark(value: .sharp)]),
                       MXLOrnaments.Entry(content: .wavyLine(MXLWavyLine(kind: .start)))]
        let value = MXLOrnaments(id: "o1", entries: entries)

        #expect(value.entries == entries)
        #expect(value.id == "o1")
    }
}
