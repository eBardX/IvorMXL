// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLTrillBeatsTests {
}

// MARK: -

extension MXLTrillBeatsTests {
    @Test
    func formatDecimal_roundTrips() {
        let text = MXLFormatter.Writer().formatDecimal(3.5)

        #expect(MXLParser.parseTrillBeats(text) == 3.5)
    }

    @Test
    func parseTrillBeats_decimal() {
        #expect(MXLParser.parseTrillBeats("3.5") == 3.5)
    }

    @Test
    func parseTrillBeats_integer() {
        #expect(MXLParser.parseTrillBeats("3") == 3)
    }

    @Test
    func parseTrillBeats_nonNumeric() {
        #expect(MXLParser.parseTrillBeats("wide") == nil)
    }
}
