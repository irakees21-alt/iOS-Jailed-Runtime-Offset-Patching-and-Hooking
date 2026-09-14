#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#include "dobby_defines.h"

uintptr_t getRealOffset(uintptr_t offset) {
    return _dyld_get_image_header(0) + offset;
}

__attribute__((constructor)) static void init() {
    // الانتظار 5 ثوانٍ لتفادي الكراش التلقائي عند تشغيل اللعبة
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 1. أيم صغير 🧊 (Offset: 0x345C504 | Byte: E003271E)
        DobbyPatch((void*)getRealOffset(0x345C504), (uint8_t*)"\x1E\x27\x03\xE0", 4);

        // 2. أيم بوت 🎯 (Offset: 0x2FCA774 | Byte: 08F0271E)
        DobbyPatch((void*)getRealOffset(0x2FCA774), (uint8_t*)"\x1E\x27\xF0\x08", 4);

        // 3. لون لاعب أحمر 🔴 (Offset: 0x66EEDA0 | Byte: 00F0271E)
        DobbyPatch((void*)getRealOffset(0x66EEDA0), (uint8_t*)"\x1E\x27\xF0\x00", 4);

        // 4. ثبات سلاح ⚡ (Offset: 0x345F640 | Byte: C0035FD6)
        DobbyPatch((void*)getRealOffset(0x345F640), (uint8_t*)"\xD6\x5F\x03\xC0", 4);
        
    });
}
