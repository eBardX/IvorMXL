// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFontFamilyTests {
}

// MARK: -

extension MXLFontFamilyTests {
    @Test
    func fontAttributes_joinsFamily() {
        let attributes = MXLFormatter.Writer().fontAttributes(MXLFont(family: ["Bravura", "serif"]))

        #expect(attributes.contains { $0.0 == .fontFamily && $0.1 == "Bravura,serif" })
    }

    @Test
    func parseFont_family() throws {
        let font = try MXLParser.parseFont(node(#"<words font-family="Bravura, serif">x</words>"#))

        #expect(font.family == ["Bravura", "serif"])
    }

    @Test
    func parseFont_noFamily() throws {
        let font = try MXLParser.parseFont(node("<words>x</words>"))

        #expect(font.family == nil)
    }
}
