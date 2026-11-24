// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLRotationDegreesTests {
}

// MARK: -

extension MXLRotationDegreesTests {
    @Test
    func formatDecimal_roundTrips() {
        let text = MXLFormatter.Writer().formatDecimal(-90.0)

        #expect(MXLParser.parseRotationDegrees(text) == -90.0)
    }

    @Test
    func parseRotationDegrees_decimal() {
        #expect(MXLParser.parseRotationDegrees("-90") == -90.0)
    }

    @Test
    func parseRotationDegrees_integer() {
        #expect(MXLParser.parseRotationDegrees("3") == 3)
    }

    @Test
    func parseRotationDegrees_nonNumeric() {
        #expect(MXLParser.parseRotationDegrees("wide") == nil)
    }
}
