// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLFormatterWriterDocumentTests {
}

// MARK: -

extension MXLFormatterWriterDocumentTests {
    @Test
    func writeDocument_opusWritesOpusProlog() throws {
        var writer = MXLFormatter.Writer()
        let opus = MXLOpus(version: .v4_0,
                           title: "Works",
                           items: [])

        try writer.writeDocument(.opus(opus))

        #expect(writer.document.documentType?.name == "opus")
        #expect(writer.document.root.element == .opus)
    }

    @Test
    func writeDocument_partwiseWritesPartwiseProlog() throws {
        var writer = MXLFormatter.Writer()
        let score = try partwise("minimal-partwise.musicxml")

        try writer.writeDocument(.scorePartwise(score))

        #expect(writer.document.documentType?.name == "score-partwise")
        #expect(writer.document.root.element == .scorePartwise)
    }

    @Test
    func writeDocument_timewiseThrows() throws {
        var writer = MXLFormatter.Writer()
        let score = try timewise("minimal-timewise.musicxml")

        #expect(throws: MXLFormatter.Error.self) {
            try writer.writeDocument(.scoreTimewise(score))
        }
    }
}
