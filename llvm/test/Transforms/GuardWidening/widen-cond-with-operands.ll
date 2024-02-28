; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -S -passes=guard-widening,verify < %s | FileCheck %s
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128-ni:1-p2:32:8:8:32-ni:2"
target triple = "x86_64-unknown-linux-gnu"

; Make sure GuardWidening moves 'check' instruction before 'wc1' together with its operand - 'zero'.
define void @foo() {
; CHECK-LABEL: @foo(
; CHECK-NEXT:  bb:
; CHECK-NEXT:    [[ZERO:%.*]] = add i32 0, 0
; CHECK-NEXT:    [[WIDE_CHK:%.*]] = icmp ult i32 [[ZERO]], 0
; CHECK-NEXT:    [[WC1:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[WC2:%.*]] = call i1 @llvm.experimental.widenable.condition()
; CHECK-NEXT:    [[CHECK:%.*]] = icmp ult i32 [[ZERO]], 0
; CHECK-NEXT:    [[C2:%.*]] = and i1 [[CHECK]], [[WC2]]
; CHECK-NEXT:    [[C1:%.*]] = and i1 [[WIDE_CHK]], [[WC1]]
; CHECK-NEXT:    br i1 [[C1]], label [[BB6:%.*]], label [[BB9:%.*]]
; CHECK:       bb6:
; CHECK-NEXT:    br i1 true, label [[BB7:%.*]], label [[BB8:%.*]]
; CHECK:       bb7:
; CHECK-NEXT:    ret void
; CHECK:       bb8:
; CHECK-NEXT:    call void (...) @llvm.experimental.deoptimize.isVoid(i32 0) [ "deopt"() ]
; CHECK-NEXT:    ret void
; CHECK:       bb9:
; CHECK-NEXT:    call void (...) @llvm.experimental.deoptimize.isVoid(i32 0) [ "deopt"() ]
; CHECK-NEXT:    ret void
;
bb:
  %wc1 = call i1 @llvm.experimental.widenable.condition()
  %wc2 = call i1 @llvm.experimental.widenable.condition()
  %zero = add i32 0, 0
  %check = icmp ult i32 %zero, 0
  %c1 = and i1 %check, %wc1
  %c2 = and i1 %check, %wc2
  br i1 %c1, label %bb6, label %bb9

bb6:                                              ; preds = %bb
  br i1 %c2, label %bb7, label %bb8

bb7:                                              ; preds = %bb6
  ret void

bb8:                                              ; preds = %bb6
  call void (...) @llvm.experimental.deoptimize.isVoid(i32 0) [ "deopt"() ]
  ret void

bb9:                                              ; preds = %bb
  call void (...) @llvm.experimental.deoptimize.isVoid(i32 0) [ "deopt"() ]
  ret void
}

declare void @llvm.experimental.deoptimize.isVoid(...)

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(inaccessiblemem: readwrite)
declare i1 @llvm.experimental.widenable.condition() #0

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(inaccessiblemem: readwrite) }