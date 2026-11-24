// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLCommaSeparatedTextTests {
}

// MARK: -

extension MXLCommaSeparatedTextTests {
    @Test
    func parseCommaSeparatedText_list() {
        #expect(MXLParser.parseCommaSeparatedText("Times New Roman, serif") == ["Times New Roman", "serif"])
    }

    @Test
    func parseCommaSeparatedText_single() {
        #expect(MXLParser.parseCommaSeparatedText("Bravura") == ["Bravura"])
    }
}
