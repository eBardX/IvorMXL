// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLFormatterWriterTests {
}

// MARK: -

extension MXLFormatterWriterTests {
    @Test
    func closeElement_nestsChildrenInOrder() {
        let written = writtenNode { writer in
            writer.openElement(.pitch)
            writer.writeTextElement(.step, "G")
            writer.writeTextElement(.octave, "4")
            writer.closeElement()
        }

        #expect(written.element == .pitch)
        #expect(written.children?.map(\.element) == [.step, .octave])
    }

    @Test
    func init_hasNoProlog() {
        var writer = MXLFormatter.Writer()

        writer.writeEmptyElement(.chord)

        #expect(writer.document.declaration == nil)
        #expect(writer.document.documentType == nil)
    }

    @Test
    func openElement_lastDuplicateAttributeWins() {
        let written = writtenNode { writer in
            writer.writeEmptyElement(.tie,
                                     attributes: [(.type, "start"), (.type, "stop")])
        }

        #expect(written.attributes == [.type: "stop"])
    }

    @Test
    func writeEmptyElement_hasNoChildren() {
        let written = writtenNode { $0.writeEmptyElement(.chord) }

        #expect(written.element == .chord)
        #expect(written.children?.isEmpty == true)
    }

    @Test
    func writeProlog_partwiseDocumentType() {
        var writer = MXLFormatter.Writer()

        writer.writeProlog(.partwise,
                           version: .v3_1)
        writer.writeEmptyElement(.scorePartwise)

        #expect(writer.document.declaration != nil)
        #expect(writer.document.documentType?.publicID == "-//Recordare//DTD MusicXML 3.1 Partwise//EN")
        #expect(writer.document.documentType?.systemID == "http://www.musicxml.org/dtds/partwise.dtd")
    }

    @Test
    func writeTextElement_writesText() {
        let written = writtenNode { writer in
            writer.writeTextElement(.step,
                                    "A",
                                    attributes: [(.id, "s1")])
        }

        #expect(written.value == "A")
        #expect(written.attributes == [.id: "s1"])
    }
}
