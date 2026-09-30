// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLStepTests {
}

// MARK: -

extension MXLStepTests {
    @Test
    func equality() {
        #expect(MXLStep.c == .c)
    }

    @Test
    func hashable() {
        let values: Set<MXLStep> = [.c, .c, .d]

        #expect(values.count == 2)
    }

    @Test
    func inequality() {
        #expect(MXLStep.c != .d)
    }
}
