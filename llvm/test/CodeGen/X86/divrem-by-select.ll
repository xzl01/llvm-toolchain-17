; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64-v3 | FileCheck %s --check-prefixes=CHECK-X64,CHECK-X64-V3
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -mcpu=x86-64-v4 | FileCheck %s --check-prefixes=CHECK-X64,CHECK-X64-V4

define <2 x i64> @udiv_identity_const(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: udiv_identity_const:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: udiv_identity_const:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rdx
; CHECK-X64-V4-NEXT:    movabsq $3353953467947191203, %rax # imm = 0x2E8BA2E8BA2E8BA3
; CHECK-X64-V4-NEXT:    mulxq %rax, %rcx, %rcx
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rdx
; CHECK-X64-V4-NEXT:    mulxq %rax, %rax, %rax
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm2
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; CHECK-X64-V4-NEXT:    vpsrlq $1, %xmm0, %xmm1 {%k1}
; CHECK-X64-V4-NEXT:    vmovdqa %xmm1, %xmm0
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 11, i64 11>, <2 x i64> <i64 1, i64 1>
  %r = udiv <2 x i64> %x, %d
  ret <2 x i64> %r
}


define <2 x i64> @udiv_identity_const_todo_getter_nonzero(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: udiv_identity_const_todo_getter_nonzero:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: udiv_identity_const_todo_getter_nonzero:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rdx
; CHECK-X64-V4-NEXT:    movabsq $-3689348814741910323, %rax # imm = 0xCCCCCCCCCCCCCCCD
; CHECK-X64-V4-NEXT:    mulxq %rax, %rcx, %rcx
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rdx
; CHECK-X64-V4-NEXT:    mulxq %rax, %rax, %rax
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm2
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm2[0],xmm0[0]
; CHECK-X64-V4-NEXT:    vpsrlq $3, %xmm0, %xmm1 {%k1}
; CHECK-X64-V4-NEXT:    vmovdqa %xmm1, %xmm0
; CHECK-X64-V4-NEXT:    retq

  ;; Fails at the moment because `10` is even so there is no common
  ;; bit between the arms of the select so the default case of
  ;; isKnownNeverZero has no guaranteed 1 bits.
  %d = select <2 x i1> %c, <2 x i64> <i64 10, i64 10>, <2 x i64> <i64 1, i64 1>
  %r = udiv <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @udiv_indentity_non_zero(<2 x i1> %c, <2 x i64> %x, <2 x i64> %y) {
; CHECK-X64-V3-LABEL: udiv_indentity_non_zero:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vpcmpeqd %xmm3, %xmm3, %xmm3
; CHECK-X64-V3-NEXT:    vpsubq %xmm3, %xmm2, %xmm2
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm3 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm3 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, %xmm2, %xmm3, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: udiv_indentity_non_zero:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpcmpeqd %xmm3, %xmm3, %xmm3
; CHECK-X64-V4-NEXT:    vpsubq %xmm3, %xmm2, %xmm2
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm2, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rcx
; CHECK-X64-V4-NEXT:    movq %rax, %rcx
; CHECK-X64-V4-NEXT:    vmovq %xmm2, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rsi
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm2
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm1 {%k1} = xmm2[0],xmm0[0]
; CHECK-X64-V4-NEXT:    vmovdqa %xmm1, %xmm0
; CHECK-X64-V4-NEXT:    retq
  %non_zero = add nsw nuw <2 x i64> %y, <i64 1, i64 1>
  %d = select <2 x i1> %c, <2 x i64> %non_zero, <2 x i64> <i64 1, i64 1>
  %r = udiv <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @udiv_indentity_zero(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: udiv_indentity_zero:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpandn {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: udiv_indentity_zero:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k0
; CHECK-X64-V4-NEXT:    knotw %k0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1} {z}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rcx
; CHECK-X64-V4-NEXT:    movq %rax, %rcx
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rsi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> zeroinitializer, <2 x i64> <i64 1, i64 1>
  %r = udiv <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @udiv_indentity_partial_zero(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: udiv_indentity_partial_zero:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: udiv_indentity_partial_zero:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{.*#+}} xmm0 = [1,1]
; CHECK-X64-V4-NEXT:    vmovdqa64 {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rcx
; CHECK-X64-V4-NEXT:    movq %rax, %rcx
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rsi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 0, i64 5>, <2 x i64> <i64 1, i64 1>
  %r = udiv <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @urem_identity_const(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: urem_identity_const:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [11,11]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rcx
; CHECK-X64-V3-NEXT:    movq %rdx, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rdx, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: urem_identity_const:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{.*#+}} xmm0 = [11,11]
; CHECK-X64-V4-NEXT:    vpbroadcastq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rcx
; CHECK-X64-V4-NEXT:    movq %rdx, %rcx
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rsi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rdx, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 1, i64 1>, <2 x i64> <i64 11, i64 11>
  %r = urem <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @sdiv_identity_const(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: sdiv_identity_const:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: sdiv_identity_const:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{.*#+}} xmm0 = [1,1]
; CHECK-X64-V4-NEXT:    vmovdqa64 {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rcx
; CHECK-X64-V4-NEXT:    movq %rax, %rcx
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rsi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 11, i64 13>, <2 x i64> <i64 1, i64 1>
  %r = sdiv <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @sdiv_identity_const_todo_better_nonzero(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: sdiv_identity_const_todo_better_nonzero:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: sdiv_identity_const_todo_better_nonzero:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{.*#+}} xmm0 = [1,1]
; CHECK-X64-V4-NEXT:    vmovdqa64 {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rcx
; CHECK-X64-V4-NEXT:    movq %rax, %rcx
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rsi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 11, i64 17>, <2 x i64> <i64 1, i64 1>
  %r = sdiv <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @srem_identity_const(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: srem_identity_const:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [11,11]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rcx
; CHECK-X64-V3-NEXT:    movq %rdx, %rcx
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rsi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rdx, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: srem_identity_const:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{.*#+}} xmm0 = [11,11]
; CHECK-X64-V4-NEXT:    vpbroadcastq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rcx
; CHECK-X64-V4-NEXT:    movq %rdx, %rcx
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rsi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rdx, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 1, i64 1>, <2 x i64> <i64 11, i64 11>
  %r = srem <2 x i64> %x, %d
  ret <2 x i64> %r
}

define <2 x i64> @udivrem_identity_const(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: udivrem_identity_const:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    movq %rdx, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rdi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    xorl %edx, %edx
; CHECK-X64-V3-NEXT:    divq %rdi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    vmovq %rsi, %xmm1
; CHECK-X64-V3-NEXT:    vmovq %rdx, %xmm2
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; CHECK-X64-V3-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: udivrem_identity_const:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{.*#+}} xmm0 = [1,1]
; CHECK-X64-V4-NEXT:    vpbroadcastq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rcx
; CHECK-X64-V4-NEXT:    movq %rax, %rcx
; CHECK-X64-V4-NEXT:    movq %rdx, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rdi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    xorl %edx, %edx
; CHECK-X64-V4-NEXT:    divq %rdi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    vmovq %rsi, %xmm1
; CHECK-X64-V4-NEXT:    vmovq %rdx, %xmm2
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; CHECK-X64-V4-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 11, i64 11>, <2 x i64> <i64 1, i64 1>
  %div = udiv <2 x i64> %x, %d
  %rem = urem <2 x i64> %x, %d
  %r = add <2 x i64> %div, %rem
  ret <2 x i64> %r
}

define <2 x i64> @sdivrem_identity_const(<2 x i1> %c, <2 x i64> %x) {
; CHECK-X64-V3-LABEL: sdivrem_identity_const:
; CHECK-X64-V3:       # %bb.0:
; CHECK-X64-V3-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    vmovddup {{.*#+}} xmm2 = [1,1]
; CHECK-X64-V3-NEXT:    # xmm2 = mem[0,0]
; CHECK-X64-V3-NEXT:    vblendvpd %xmm0, {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm2, %xmm0
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V3-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rcx
; CHECK-X64-V3-NEXT:    movq %rax, %rcx
; CHECK-X64-V3-NEXT:    movq %rdx, %rsi
; CHECK-X64-V3-NEXT:    vmovq %xmm0, %rdi
; CHECK-X64-V3-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V3-NEXT:    cqto
; CHECK-X64-V3-NEXT:    idivq %rdi
; CHECK-X64-V3-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V3-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V3-NEXT:    vmovq %rsi, %xmm1
; CHECK-X64-V3-NEXT:    vmovq %rdx, %xmm2
; CHECK-X64-V3-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; CHECK-X64-V3-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; CHECK-X64-V3-NEXT:    retq
;
; CHECK-X64-V4-LABEL: sdivrem_identity_const:
; CHECK-X64-V4:       # %bb.0:
; CHECK-X64-V4-NEXT:    vpsllq $63, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    vpmovq2m %xmm0, %k1
; CHECK-X64-V4-NEXT:    vpbroadcastq {{.*#+}} xmm0 = [1,1]
; CHECK-X64-V4-NEXT:    vpbroadcastq {{\.?LCPI[0-9]+_[0-9]+}}(%rip), %xmm0 {%k1}
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm0, %rcx
; CHECK-X64-V4-NEXT:    vpextrq $1, %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rcx
; CHECK-X64-V4-NEXT:    movq %rax, %rcx
; CHECK-X64-V4-NEXT:    movq %rdx, %rsi
; CHECK-X64-V4-NEXT:    vmovq %xmm0, %rdi
; CHECK-X64-V4-NEXT:    vmovq %xmm1, %rax
; CHECK-X64-V4-NEXT:    cqto
; CHECK-X64-V4-NEXT:    idivq %rdi
; CHECK-X64-V4-NEXT:    vmovq %rcx, %xmm0
; CHECK-X64-V4-NEXT:    vmovq %rax, %xmm1
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm0 = xmm1[0],xmm0[0]
; CHECK-X64-V4-NEXT:    vmovq %rsi, %xmm1
; CHECK-X64-V4-NEXT:    vmovq %rdx, %xmm2
; CHECK-X64-V4-NEXT:    vpunpcklqdq {{.*#+}} xmm1 = xmm2[0],xmm1[0]
; CHECK-X64-V4-NEXT:    vpaddq %xmm1, %xmm0, %xmm0
; CHECK-X64-V4-NEXT:    retq
  %d = select <2 x i1> %c, <2 x i64> <i64 11, i64 11>, <2 x i64> <i64 1, i64 1>
  %div = sdiv <2 x i64> %x, %d
  %rem = srem <2 x i64> %x, %d
  %r = add <2 x i64> %div, %rem
  ret <2 x i64> %r
}
;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; CHECK-X64: {{.*}}