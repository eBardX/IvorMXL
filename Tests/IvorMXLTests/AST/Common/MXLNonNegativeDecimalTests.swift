// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLNonNegativeDecimalTests {
}

// MARK: -

extension MXLNonNegativeDecimalTests {
    @Test
    func formatDecimal_roundTrips() {
        let text = MXLFormatter.Writer().formatDecimal(0.5)

        #expect(MXLParser.parseNonNegativeDecimal(text) == 0.5)
    }

    @Test
    func parseNonNegativeDecimal_decimal() {
        #expect(MXLParser.parseNonNegativeDecimal("0.5") == 0.5)
    }

    @Test
    func parseNonNegativeDecimal_integer() {
        #expect(MXLParser.parseNonNegativeDecimal("3") == 3)
    }

    @Test
    func parseNonNegativeDecimal_nonNumeric() {
        #expect(MXLParser.parseNonNegativeDecimal("wide") == nil)
    }
}
