// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLSemitonesTests {
}

// MARK: -

extension MXLSemitonesTests {
    @Test
    func formatDecimal_roundTrips() {
        let text = MXLFormatter.Writer().formatDecimal(-1.5)

        #expect(MXLParser.parseSemitones(text) == -1.5)
    }

    @Test
    func parseSemitones_decimal() {
        #expect(MXLParser.parseSemitones("-1.5") == -1.5)
    }

    @Test
    func parseSemitones_integer() {
        #expect(MXLParser.parseSemitones("3") == 3)
    }

    @Test
    func parseSemitones_nonNumeric() {
        #expect(MXLParser.parseSemitones("wide") == nil)
    }
}
