#pragma once


extern "C" _int64 min(_int64, _int64, _int64);
extern "C" _int64 p(_int64, _int64, _int64, _int64);
extern "C" _int64 gcd(_int64, _int64);
extern "C" _int64 q(_int64, _int64, _int64, _int64, _int64);
extern "C" _int64 qns();
extern "C" _int64 qnsa();
extern "C" _int64 g;

//
// NB: "extern C" to avoid procedure name mangling by C++ compiler
//

extern "C" _int64 fibX64(_int64);			// fib_x64

// eof