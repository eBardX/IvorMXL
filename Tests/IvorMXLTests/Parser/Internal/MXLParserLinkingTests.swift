// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserLinkingTests {
}

// MARK: -

extension MXLParserLinkingTests {
    @Test
    func parseBookmark() throws {
        let bookmark = try MXLParser.parseBookmark(node(#"<bookmark id="b1" name="Coda" element="note" position="2"/>"#))

        #expect(bookmark.id == "b1")
        #expect(bookmark.name == "Coda")
        #expect(bookmark.elementPosition.position == 2)
    }

    @Test
    func parseBookmark_missingIDThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseBookmark(node(#"<bookmark name="x"/>"#))
        }
    }

    @Test
    func parseXLink() throws {
        let xlink = try MXLParser.parseXLink(node(#"""
            <link xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="score.xml" xlink:show="new" xlink:actuate="onLoad" xlink:title="Score"/>
            """#))

        #expect(xlink.href == "score.xml")
        #expect(xlink.show == .new)
        #expect(xlink.actuate == .onLoad)
        #expect(xlink.title == "Score")
    }

    @Test
    func parseXLink_missingHrefThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseXLink(node(#"<link/>"#))
        }
    }

    @Test
    func parseXLinkActuate_invalidValue() {
        #expect(MXLParser.parseXLinkActuate("bogus") == nil)
    }

    @Test
    func parseXLinkActuate_validValues() {
        #expect(MXLParser.parseXLinkActuate("none") == .unspecified)
        #expect(MXLParser.parseXLinkActuate("onLoad") == .onLoad)
        #expect(MXLParser.parseXLinkActuate("onRequest") == .onRequest)
        #expect(MXLParser.parseXLinkActuate("other") == .other)
    }

    @Test
    func parseXLinkShow_invalidValue() {
        #expect(MXLParser.parseXLinkShow("bogus") == nil)
    }

    @Test
    func parseXLinkShow_validValues() {
        #expect(MXLParser.parseXLinkShow("embed") == .embed)
        #expect(MXLParser.parseXLinkShow("new") == .new)
        #expect(MXLParser.parseXLinkShow("none") == .undefined)
        #expect(MXLParser.parseXLinkShow("other") == .other)
        #expect(MXLParser.parseXLinkShow("replace") == .replace)
    }
}
