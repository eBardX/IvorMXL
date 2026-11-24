// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing
import XestiTools

struct MXLValidatorErrorTests {
}

// MARK: -

extension MXLValidatorErrorTests {
    @Test
    func equality() {
        #expect(MXLValidator.Error.notNormalized == .notNormalized)
    }

    @Test
    func message_isNotEmpty() {
        let allCases: [MXLValidator.Error] = [.notNormalized]

        for error in allCases {
            #expect(!error.message.isEmpty)
            #expect(error.category == Category("IvorMXL"))
        }
    }

    @Test
    func message_namesTheRemedy() {
        #expect(MXLValidator.Error.notNormalized.message.contains("MXLNormalizer.normalize(_:)"))
    }
}
