// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLParserLyricTests {
}

// MARK: -

extension MXLParserLyricTests {
    @Test
    func parseLyric_extendOnly() throws {
        let lyric = try MXLParser.parseLyric(node(#"<lyric><extend type="continue"/></lyric>"#))

        guard case let .extend(extend) = lyric.content
        else { Issue.record("expected extend-only content"); return }

        #expect(extend.kind == .continue)
    }

    @Test
    func parseLyric_laughing() throws {
        let lyric = try MXLParser.parseLyric(node("<lyric><laughing/><end-line/></lyric>"))

        #expect(lyric.content == .laughing)
        #expect(lyric.endsLine)
    }

    @Test
    func parseLyric_syllables() throws {
        let lyric = try MXLParser.parseLyric(node(#"""
            <lyric number="1" placement="below"><syllabic>begin</syllabic><text>Hal</text><elision>_</elision>
            <syllabic>end</syllabic><text>le</text></lyric>
            """#))

        #expect(lyric.number == "1")
        #expect(lyric.placement == .below)
    }

    @Test
    func parseLyricLanguage() throws {
        let language = try MXLParser.parseLyricLanguage(node(#"<lyric-language number="2" name="verse" xml:lang="it"/>"#))

        #expect(language == MXLLyricLanguage(number: "2",
                                             name: "verse",
                                             xmlLang: "it"))
    }

    @Test
    func parseSyllabic_invalidValue() {
        #expect(MXLParser.parseSyllabic("bogus") == nil)
    }

    @Test
    func parseSyllabic_validValues() {
        #expect(MXLParser.parseSyllabic("begin") == .begin)
        #expect(MXLParser.parseSyllabic("end") == .end)
        #expect(MXLParser.parseSyllabic("middle") == .middle)
        #expect(MXLParser.parseSyllabic("single") == .single)
    }
}
