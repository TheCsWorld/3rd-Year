#pragma once

//
// t1.h
//
// example of mixing C++ and IA32 assembly language
//

//
// NB: "extern C" to avoid procedure name mangling by compiler
//
extern "C" int _cdecl min_IA32(int, int, int);
extern "C" int _cdecl p_IA32(int, int, int, int);
extern "C" int _cdecl gcd_IA32(int, int);
//extern "C" int g;

//extern "C" int _cdecl fib_IA32a(int);   // _cdecl calling convention
//extern "C" int _cdecl fib_IA32b(int);   // _cdecl calling convention

// eof