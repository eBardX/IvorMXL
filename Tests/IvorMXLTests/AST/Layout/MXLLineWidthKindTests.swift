// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLLineWidthKindTests {
}

// MARK: -

extension MXLLineWidthKindTests {
    @Test
    func parseLineWidth_keepsKindVerbatim() throws {
        let value = try MXLParser.parseLineWidth(node(#"<line-width type="light barline">1</line-width>"#))

        #expect(value.kind == "light barline")
    }

    @Test
    func parseLineWidth_missingKindThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseLineWidth(node("<line-width>1</line-width>"))
        }
    }
}
