; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=aarch64-none-linux-gnu -mattr=+neon | FileCheck %s --check-prefix=CHECK

declare i1 @llvm.vector.reduce.and.v1i1(<1 x i1> %a)
declare i8 @llvm.vector.reduce.and.v1i8(<1 x i8> %a)
declare i16 @llvm.vector.reduce.and.v1i16(<1 x i16> %a)
declare i24 @llvm.vector.reduce.and.v1i24(<1 x i24> %a)
declare i32 @llvm.vector.reduce.and.v1i32(<1 x i32> %a)
declare i64 @llvm.vector.reduce.and.v1i64(<1 x i64> %a)
declare i128 @llvm.vector.reduce.and.v1i128(<1 x i128> %a)

declare i8 @llvm.vector.reduce.and.v3i8(<3 x i8> %a)
declare i8 @llvm.vector.reduce.and.v9i8(<9 x i8> %a)
declare i32 @llvm.vector.reduce.and.v3i32(<3 x i32> %a)
declare i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %a)
declare i24 @llvm.vector.reduce.and.v4i24(<4 x i24> %a)
declare i128 @llvm.vector.reduce.and.v2i128(<2 x i128> %a)
declare i32 @llvm.vector.reduce.and.v16i32(<16 x i32> %a)

define i1 @test_v1i1(<1 x i1> %a) nounwind {
; CHECK-LABEL: test_v1i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and w0, w0, #0x1
; CHECK-NEXT:    ret
  %b = call i1 @llvm.vector.reduce.and.v1i1(<1 x i1> %a)
  ret i1 %b
}

define i8 @test_v1i8(<1 x i8> %a) nounwind {
; CHECK-LABEL: test_v1i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w0, v0.b[0]
; CHECK-NEXT:    ret
  %b = call i8 @llvm.vector.reduce.and.v1i8(<1 x i8> %a)
  ret i8 %b
}

define i16 @test_v1i16(<1 x i16> %a) nounwind {
; CHECK-LABEL: test_v1i16:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    umov w0, v0.h[0]
; CHECK-NEXT:    ret
  %b = call i16 @llvm.vector.reduce.and.v1i16(<1 x i16> %a)
  ret i16 %b
}

define i24 @test_v1i24(<1 x i24> %a) nounwind {
; CHECK-LABEL: test_v1i24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %b = call i24 @llvm.vector.reduce.and.v1i24(<1 x i24> %a)
  ret i24 %b
}

define i32 @test_v1i32(<1 x i32> %a) nounwind {
; CHECK-LABEL: test_v1i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    fmov w0, s0
; CHECK-NEXT:    ret
  %b = call i32 @llvm.vector.reduce.and.v1i32(<1 x i32> %a)
  ret i32 %b
}

define i64 @test_v1i64(<1 x i64> %a) nounwind {
; CHECK-LABEL: test_v1i64:
; CHECK:       // %bb.0:
; CHECK-NEXT:    // kill: def $d0 killed $d0 def $q0
; CHECK-NEXT:    fmov x0, d0
; CHECK-NEXT:    ret
  %b = call i64 @llvm.vector.reduce.and.v1i64(<1 x i64> %a)
  ret i64 %b
}

define i128 @test_v1i128(<1 x i128> %a) nounwind {
; CHECK-LABEL: test_v1i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ret
  %b = call i128 @llvm.vector.reduce.and.v1i128(<1 x i128> %a)
  ret i128 %b
}

define i8 @test_v3i8(<3 x i8> %a) nounwind {
; CHECK-LABEL: test_v3i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    movi d0, #0xff00ff00ff00ff
; CHECK-NEXT:    mov v0.h[0], w0
; CHECK-NEXT:    mov v0.h[1], w1
; CHECK-NEXT:    mov v0.h[2], w2
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    and x8, x8, x8, lsr #32
; CHECK-NEXT:    lsr x9, x8, #16
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %b = call i8 @llvm.vector.reduce.and.v3i8(<3 x i8> %a)
  ret i8 %b
}

define i8 @test_v9i8(<9 x i8> %a) nounwind {
; CHECK-LABEL: test_v9i8:
; CHECK:       // %bb.0:
; CHECK-NEXT:    mov w8, #-1 // =0xffffffff
; CHECK-NEXT:    mov v1.16b, v0.16b
; CHECK-NEXT:    mov v1.b[9], w8
; CHECK-NEXT:    mov v1.b[10], w8
; CHECK-NEXT:    mov v1.b[11], w8
; CHECK-NEXT:    mov v1.b[12], w8
; CHECK-NEXT:    mov v1.b[13], w8
; CHECK-NEXT:    mov v1.b[14], w8
; CHECK-NEXT:    mov v1.b[15], w8
; CHECK-NEXT:    ext v1.16b, v1.16b, v1.16b, #8
; CHECK-NEXT:    and v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    and x8, x8, x8, lsr #32
; CHECK-NEXT:    and x8, x8, x8, lsr #16
; CHECK-NEXT:    lsr x9, x8, #8
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %b = call i8 @llvm.vector.reduce.and.v9i8(<9 x i8> %a)
  ret i8 %b
}

define i32 @test_v3i32(<3 x i32> %a) nounwind {
; CHECK-LABEL: test_v3i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    lsr x8, x8, #32
; CHECK-NEXT:    and v1.8b, v0.8b, v1.8b
; CHECK-NEXT:    fmov x9, d1
; CHECK-NEXT:    and w0, w9, w8
; CHECK-NEXT:    ret
  %b = call i32 @llvm.vector.reduce.and.v3i32(<3 x i32> %a)
  ret i32 %b
}

define i1 @test_v4i1(<4 x i1> %a) nounwind {
; CHECK-LABEL: test_v4i1:
; CHECK:       // %bb.0:
; CHECK-NEXT:    shl v0.4h, v0.4h, #15
; CHECK-NEXT:    cmlt v0.4h, v0.4h, #0
; CHECK-NEXT:    uminv h0, v0.4h
; CHECK-NEXT:    fmov w8, s0
; CHECK-NEXT:    and w0, w8, #0x1
; CHECK-NEXT:    ret
  %b = call i1 @llvm.vector.reduce.and.v4i1(<4 x i1> %a)
  ret i1 %b
}

define i24 @test_v4i24(<4 x i24> %a) nounwind {
; CHECK-LABEL: test_v4i24:
; CHECK:       // %bb.0:
; CHECK-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    and v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    lsr x9, x8, #32
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %b = call i24 @llvm.vector.reduce.and.v4i24(<4 x i24> %a)
  ret i24 %b
}

define i128 @test_v2i128(<2 x i128> %a) nounwind {
; CHECK-LABEL: test_v2i128:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and x0, x0, x2
; CHECK-NEXT:    and x1, x1, x3
; CHECK-NEXT:    ret
  %b = call i128 @llvm.vector.reduce.and.v2i128(<2 x i128> %a)
  ret i128 %b
}

define i32 @test_v16i32(<16 x i32> %a) nounwind {
; CHECK-LABEL: test_v16i32:
; CHECK:       // %bb.0:
; CHECK-NEXT:    and v1.16b, v1.16b, v3.16b
; CHECK-NEXT:    and v0.16b, v0.16b, v2.16b
; CHECK-NEXT:    and v0.16b, v0.16b, v1.16b
; CHECK-NEXT:    ext v1.16b, v0.16b, v0.16b, #8
; CHECK-NEXT:    and v0.8b, v0.8b, v1.8b
; CHECK-NEXT:    fmov x8, d0
; CHECK-NEXT:    lsr x9, x8, #32
; CHECK-NEXT:    and w0, w8, w9
; CHECK-NEXT:    ret
  %b = call i32 @llvm.vector.reduce.and.v16i32(<16 x i32> %a)
  ret i32 %b
}