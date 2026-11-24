// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiXML

struct MXLFormatterWriterAttributes2Tests {
}

// MARK: -

extension MXLFormatterWriterAttributes2Tests {
    @Test
    func writeTranspose_roundTrips() throws {
        let original = try MXLParser.parseTranspose(node(#"""
            <transpose number="2"><diatonic>-1</diatonic><chromatic>-2</chromatic><octave-change>-1</octave-change>
            <double above="yes"/></transpose>
            """#))
        let written = writtenNode { $0.writeTranspose(original) }

        #expect(try MXLParser.parseTranspose(written) == original)
    }

    @Test
    func writeTransposeContent_omitsAbsentElements() {
        let content = MXLTranspose.Content(chromatic: 2)
        let written = writtenNodes { $0.writeTransposeContent(content) }

        #expect(written.map(\.element) == [.chromatic])
    }

    @Test
    func writeTransposeContent_roundTrips() throws {
        let original = try MXLParser.parseTransposeContent(node(#"<transpose><chromatic>3.5</chromatic></transpose>"#))
        let written = writtenNode(in: .transpose) { $0.writeTransposeContent(original) }

        #expect(try MXLParser.parseTransposeContent(written) == original)
    }

    @Test
    func writeTuning_roundTrips() throws {
        let original = try MXLParser.parseTuning(node(#"""
            <staff-tuning><tuning-step>D</tuning-step><tuning-alter>-1</tuning-alter><tuning-octave>3</tuning-octave>
            </staff-tuning>
            """#))
        let written = writtenNode(in: .staffTuning) { $0.writeTuning(original) }

        #expect(try MXLParser.parseTuning(written) == original)
    }
}
