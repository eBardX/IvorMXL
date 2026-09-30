// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLMembraneValueTests {
}

// MARK: -

extension MXLMembraneValueTests {
    @Test
    func equality() {
        #expect(MXLMembrane.Value.bassDrum == .bassDrum)
    }

    @Test
    func hashable() {
        let values: Set<MXLMembrane.Value> = [.bassDrum, .bassDrum, .tambourine]

        #expect(values.count == 2)
    }

    @Test
    func inequality() {
        #expect(MXLMembrane.Value.bassDrum != .tambourine)
    }
}
