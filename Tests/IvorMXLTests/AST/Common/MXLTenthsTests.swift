// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLTenthsTests {
}

// MARK: -

extension MXLTenthsTests {
    @Test
    func formatDecimal_roundTrips() {
        let text = MXLFormatter.Writer().formatDecimal(-12.5)

        #expect(MXLParser.parseTenths(text) == -12.5)
    }

    @Test
    func parseTenths_decimal() {
        #expect(MXLParser.parseTenths("-12.5") == -12.5)
    }

    @Test
    func parseTenths_integer() {
        #expect(MXLParser.parseTenths("3") == 3)
    }

    @Test
    func parseTenths_nonNumeric() {
        #expect(MXLParser.parseTenths("wide") == nil)
    }
}
