// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLOrnamentsEntryTests {
}

// MARK: -

extension MXLOrnamentsEntryTests {
    @Test
    func equality() {
        let content = MXLOrnaments.Content.trillMark(MXLEmptyTrillSound())

        #expect(MXLOrnaments.Entry(content: content) == MXLOrnaments.Entry(content: content))    // swiftlint:disable:this identical_operands
    }

    @Test
    func hashable() {
        let content = MXLOrnaments.Content.trillMark(MXLEmptyTrillSound())
        let values: Set<MXLOrnaments.Entry> = [MXLOrnaments.Entry(content: content),
                                               MXLOrnaments.Entry(content: content),
                                               MXLOrnaments.Entry(content: content, accidentalMarks: [MXLAccidentalMark(value: .flat)])]

        #expect(values.count == 2)
    }

    @Test
    func init_defaultValues() {
        let content = MXLOrnaments.Content.trillMark(MXLEmptyTrillSound())
        let value = MXLOrnaments.Entry(content: content)

        #expect(value.accidentalMarks.isEmpty)
        #expect(value.content == content)
    }

    @Test
    func init_explicitValues() {
        let content = MXLOrnaments.Content.mordent(MXLMordent())
        let accidentalMarks = [MXLAccidentalMark(value: .sharp)]
        let value = MXLOrnaments.Entry(content: content, accidentalMarks: accidentalMarks)

        #expect(value.accidentalMarks == accidentalMarks)
        #expect(value.content == content)
    }
}
