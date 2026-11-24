// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLGlyphKindTests {
}

// MARK: -

extension MXLGlyphKindTests {
    @Test
    func parseGlyph_keepsKindVerbatim() throws {
        let value = try MXLParser.parseGlyph(node(#"<glyph type="quarter-rest">1</glyph>"#))

        #expect(value.kind == "quarter-rest")
    }

    @Test
    func parseGlyph_missingKindThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseGlyph(node("<glyph>1</glyph>"))
        }
    }
}
