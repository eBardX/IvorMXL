// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLAccidentalValueTests {
}

// MARK: -

extension MXLAccidentalValueTests {
    @Test
    func equality() {
        #expect(MXLAccidentalValue.sharp == .sharp)
    }

    @Test
    func hashable() {
        let values: Set<MXLAccidentalValue> = [.sharp, .sharp, .flat]

        #expect(values.count == 2)
    }

    @Test
    func inequality() {
        #expect(MXLAccidentalValue.sharp != .flat)
    }
}
