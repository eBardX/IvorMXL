// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLPercentTests {
}

// MARK: -

extension MXLPercentTests {
    @Test
    func formatDecimal_roundTrips() {
        let text = MXLFormatter.Writer().formatDecimal(33.3)

        #expect(MXLParser.parsePercent(text) == 33.3)
    }

    @Test
    func parsePercent_decimal() {
        #expect(MXLParser.parsePercent("33.3") == 33.3)
    }

    @Test
    func parsePercent_integer() {
        #expect(MXLParser.parsePercent("3") == 3)
    }

    @Test
    func parsePercent_nonNumeric() {
        #expect(MXLParser.parsePercent("wide") == nil)
    }
}
