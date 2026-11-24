// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLFormatterWriterPercussionTests {
}

// MARK: -

extension MXLFormatterWriterPercussionTests {
    @Test
    func writeBeater_roundTrips() throws {
        let original = try MXLParser.parseBeater(node(#"<beater tip="northeast">jazz stick</beater>"#))
        let written = writtenNode { $0.writeBeater(original) }

        #expect(try MXLParser.parseBeater(written) == original)
    }

    @Test
    func writeEffect_roundTrips() throws {
        let original = try MXLParser.parseEffect(node(#"<effect smufl="pictThundersheet">thunder sheet</effect>"#))
        let written = writtenNode { $0.writeEffect(original) }

        #expect(try MXLParser.parseEffect(written) == original)
    }

    @Test
    func writeGlass_roundTrips() throws {
        let original = try MXLParser.parseGlass(node(#"<glass>wind chimes</glass>"#))
        let written = writtenNode { $0.writeGlass(original) }

        #expect(try MXLParser.parseGlass(written) == original)
    }

    @Test
    func writeMembrane_roundTrips() throws {
        let original = try MXLParser.parseMembrane(node(#"<membrane>snare drum snares off</membrane>"#))
        let written = writtenNode { $0.writeMembrane(original) }

        #expect(try MXLParser.parseMembrane(written) == original)
    }

    @Test
    func writeMetal_roundTrips() throws {
        let original = try MXLParser.parseMetal(node(#"<metal>high-hat cymbals</metal>"#))
        let written = writtenNode { $0.writeMetal(original) }

        #expect(try MXLParser.parseMetal(written) == original)
    }
}
