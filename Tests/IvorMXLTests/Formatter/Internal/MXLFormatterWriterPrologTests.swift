// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterPrologTests {
}

// MARK: -

extension MXLFormatterWriterPrologTests {
    @Test
    func hierarchy() {
        #expect(MXLFormatter.Writer.Prolog.opus.hierarchy == "Opus")
        #expect(MXLFormatter.Writer.Prolog.partwise.hierarchy == "Partwise")
        #expect(MXLFormatter.Writer.Prolog.timewise.hierarchy == "Timewise")
    }

    @Test
    func name() {
        #expect(MXLFormatter.Writer.Prolog.opus.name == "opus")
        #expect(MXLFormatter.Writer.Prolog.partwise.name == "score-partwise")
        #expect(MXLFormatter.Writer.Prolog.timewise.name == "score-timewise")
    }

    @Test
    func systemIDStem() {
        #expect(MXLFormatter.Writer.Prolog.opus.systemIDStem == "opus")
        #expect(MXLFormatter.Writer.Prolog.partwise.systemIDStem == "partwise")
        #expect(MXLFormatter.Writer.Prolog.timewise.systemIDStem == "timewise")
    }
}
