// © 2026 John Gary Pusey (see LICENSE.md)

import Foundation
@testable import IvorMXL
import Testing
import XestiXML

struct MXLParserContainerTests {
}

// MARK: -

extension MXLParserContainerTests {
    @Test
    func parseContainer_data() throws {
        let container = try MXLParser.parseContainer(Data(#"""
            <container><rootfiles><rootfile full-path="score.xml" media-type="application/vnd.recordare.musicxml+xml"/>
            <rootfile full-path="score.pdf" media-type="application/pdf"/></rootfiles></container>
            """#.utf8))

        #expect(container.rootfiles.map(\.fullPath) == ["score.xml", "score.pdf"])
        #expect(container.rootfiles.last?.mediaType == "application/pdf")
    }

    @Test
    func parseContainer_missingRootfilesThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseContainer(node(#"<container/>"#))
        }
    }

    @Test
    func parseContainer_wrongElementThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseContainer(node(#"<rootfiles/>"#))
        }
    }

    @Test
    func parseContainerRootfile_missingFullPathThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseContainerRootfile(node(#"<rootfile/>"#))
        }
    }

    @Test
    func parseContainerRootfiles_emptyThrows() {
        #expect(throws: (any Error).self) {
            try MXLParser.parseContainerRootfiles(node(#"<rootfiles/>"#))
        }
    }
}
