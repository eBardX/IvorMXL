// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLDistanceKindTests {
}

// MARK: -

extension MXLDistanceKindTests {
    @Test
    func parseDistance_keepsKindVerbatim() throws {
        let value = try MXLParser.parseDistance(node(#"<distance type="hyphen">1</distance>"#))

        #expect(value.kind == "hyphen")
    }

    @Test
    func parseDistance_missingKindThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseDistance(node("<distance>1</distance>"))
        }
    }
}
