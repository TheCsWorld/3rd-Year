//
// t1Test.cpp
//
// Copyright (C) 2017 jones@scss.tcd.ie
//
// 02/10/17	first version
//

#include "pch.h"         // pre-compiled headers
#include "tchar.h"
#include <iostream>         // cout
#include "conio.h"          // _getch
#include "t1.h"             //
#include "fib32.h"          //

using namespace std;        // cout

//
// fib: C++
//
int fib(int n) {
	int fi, fj, t;

	if (n <= 1)
		return n;

	fi = 0;
	fj = 1;
	while (n > 1) {
		t = fj;
		fj = fi + fj;
		fi = t;
		n--;
	}
	return fj;
}

int g = 4;
int min(int a, int b, int c) {
int v = a;
if (b < v)
v = b;
if (c < v)
v = c;
return v;
}
int p(int i, int j, int k, int l) {
return min(min(g, i, j), k, l);
}
int gcd(int a, int b) {
if (b == 0) {
return a;
} else {
return gcd(b, a % b);
}
}

//
// fib: C/C++ and inline IA32 assembly language
//
int fib_IA32(int n) {
	_asm {      mov eax, n          }   // mov n into eax
	_asm {      cmp eax, 1          }   // if (n <= 0)
	_asm {      jle L3              }   // return n
	_asm {      xor ecx, ecx        }   // fi = 0
	_asm {      mov edx, 1          }   // fj = 1
	_asm {L1:   cmp eax, 1          }   // while (n > 1)
	_asm {      jle L2              }   //
	_asm {      mov ebx, ecx        }   // ebx = fi
	_asm {      add ebx, edx        }   // ebx = fi + fj
	_asm {      mov ecx, edx        }   // fi = fj
	_asm {      mov edx, ebx        }   // fj = ebx
	_asm {      dec eax             }   // n--
	_asm {      jmp L1              }   //
	_asm {L2:   mov eax, edx        }   // eax = fj
	_asm {L3:                       }   //
}

//
// check
//
void check(const char *s, int v, int expected) {
	cout << s << " = " << v;
	if (v == expected) {
		cout << " OK";
	}
	else {
		cout << " ERROR: should be " << expected;
	}
	cout << endl;
}

//
// _tmain
//
int _tmain(int argc, _TCHAR* argv[]) {

	min(1, 2, 2);

	//
	// t1
	//
	check("g", g, 4);

	check("min(1, 2, 3)", min(1, 2, 3), 1);
	check("min(3, 1, 2)", min(3, 1, 2), 1);
	check("min(2, 3, 1)", min(2, 3, 1), 1);
	check("min(-1, -2, -3)", min(-1, -2, -3), -3);
	check("min(-3, -1, -2)", min(-3, -1, -2), -3);
	check("min(-2, -3, -1)", min(-2, -3, -1), -3);
	check("min(-1, 2, 3)", min(-1, 2, 3), -1);
	check("min(3, -1, 2)", min(3, -1, 2), -1);
	check("min(2, 3, -1)", min(2, 3, -1), -1);

	check("p(0, 1, 2, 3)", p(0, 1, 2, 3), 0);
	check("p(5, 6, 7, 8)", p(5, 6, 7, 8), 4);
	check("p(3, 2, 1, 0)", p(3, 2, 1, 0), 0);
	check("p(8, 7, 6, 5)", p(8, 7, 6, 5), 4);

	check("gcd(14, 21)", gcd(14, 21), 7);
	check("gcd(1406700, 164115)", gcd(1406700, 164115), 23445);

	cout << endl;

	//
	// fib: C++
	//
	for (int i = -1; i < 20; i++)
		cout << fib(i) << " ";
	cout << endl;

	//
	// fib: mixed C++ and assmbly language
	//
	for (int i = -1; i < 20; i++)
		cout << fib_IA32(i) << " ";
	cout << endl;

	//
	// fib: IA32 assembly language  unoptimised (DEBUG version)
	//
	fib_IA32a(10);
	for (int i = -1; i < 20; i++)
		cout << fib_IA32a(i) << " ";
	cout << endl;

	//
	// fib: IA32 assembly language optimised (RELEASE version)
	//
	for (int i = -1; i < 20; i++)
		cout << fib_IA32b(i) << " ";
	cout << endl;

	_getch();


	return 0;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
