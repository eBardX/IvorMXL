// © 2026 John Gary Pusey (see LICENSE.md)

@testable import IvorMXL
import Testing

struct MXLStandardSoundIDTests {
}

// MARK: -

extension MXLStandardSoundIDTests {
    @Test
    func all_containsStandardSounds() {
        #expect(MXLStandardSoundID.all.contains("keyboard.piano"))
        #expect(MXLStandardSoundID.all.contains("brass.trumpet"))
    }

    @Test
    func all_excludesNonStandardSounds() {
        #expect(!MXLStandardSoundID.all.contains("keyboard.pianoforte"))
        #expect(!MXLStandardSoundID.all.contains("Keyboard.Piano"))
    }

    @Test
    func all_isLowercaseAndDotted() {
        for sound in MXLStandardSoundID.all {
            #expect(sound == sound.lowercased())
            #expect(sound.contains("."))
        }
    }
}
