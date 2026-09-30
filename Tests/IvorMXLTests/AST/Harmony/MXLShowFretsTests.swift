// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLShowFretsTests {
}

// MARK: -

extension MXLShowFretsTests {
    @Test
    func equality() {
        #expect(MXLShowFrets.numbers == .numbers)
    }

    @Test
    func hashable() {
        let values: Set<MXLShowFrets> = [.numbers, .numbers, .letters]

        #expect(values.count == 2)
    }

    @Test
    func inequality() {
        #expect(MXLShowFrets.numbers != .letters)
    }
}
