// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLMillimetersTests {
}

// MARK: -

extension MXLMillimetersTests {
    @Test
    func formatDecimal_roundTrips() {
        let text = MXLFormatter.Writer().formatDecimal(7.0556)

        #expect(MXLParser.parseMillimeters(text) == 7.0556)
    }

    @Test
    func parseMillimeters_decimal() {
        #expect(MXLParser.parseMillimeters("7.0556") == 7.0556)
    }

    @Test
    func parseMillimeters_integer() {
        #expect(MXLParser.parseMillimeters("3") == 3)
    }

    @Test
    func parseMillimeters_nonNumeric() {
        #expect(MXLParser.parseMillimeters("wide") == nil)
    }
}
