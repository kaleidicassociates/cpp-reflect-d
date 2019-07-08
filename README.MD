Based of cppyy-backend fork of Cling C++ interpreter.  Wrapper around C interface to enable reflection on C/C++ code at runtime

# Status: alpha.

I have successfully called cpp method taking an std::string from a D string and called a method that returns an std::string.  doubles and ints seem to work too.


# TODO:

1. proper linux build
2. windows build
3. tests
4. introspect and call on functions not just methods
5. generate D declarations for selected types/functions
6. use this as a building block to create the tool we discussed at dconf - automated search + fuzzer for C++/D ABI and mangling.  tool should also verify correctness of STL/other C++ bindings we are starting to include in druntime


# Building

1.clone root from https://github.com/root-project/root/

2. build root with pyroot_experimental enabled: from repo root: `mkdir -p build && cd build && cmake -Dpyroot_experimental=true .. && make -j 8` - this will build the libcppyy_backend.so library that includes the libcling wrappers

3. copy the libcppyy_backend.so file into the directory for capi.dpp

4. capi.dpp needs the files from https://github.com/root-project/root/tree/master/bindings/pyroot_experimental/cppyy/cppyy-backend/clingwrapper/src

4. to build and run unit test:
`d++ --keep-d-files capi.dpp -L-lstdc++ -L-L. -L-lcppyy_backend -unittest -main -J. -version=UnitTest && LD_LIBRARY_PATH=. ./capi`

5. to build and run main:
`d++ --keep-d-files capi.dpp -L-lstdc++ -L-L. -L-lcppyy_backend && LD_LIBRARY_PATH=. ./capi hw.c`


# Example usage:

hw.c
```c
#include <stdio.h>
#include <vector>

int nomain()
{
	printf("hello world\n");
	return 2+2;
}

struct Foo
{
	int i;
	double d;
	std::vector<double> values;
};

struct Foo foo;
```


```d
unittest
{
        import std.exception;
        enum TestCode=import("hw.c");
        import std.experimental.logger:infof;
        enforce(compile(TestCode)==1);
        enforce(sizeOfType("Foo")==40);
    auto s = Scope("Foo");
        enforce(s.getAllCppNames == ["Foo", "d", "i", "values", "~Foo"]);
    auto m = s.dataMembers();
        enforce(m[0].name == "i");
        enforce(m[0].type == "int");
        enforce(m[0].offset == 0);
        enforce(m[1].name == "d");
        enforce(m[1].type == "double");
        enforce(m[1].offset == 8);
        enforce(m[2].name == "values");
        enforce(m[2].type == "vector<double>");
        enforce(m[2].offset == 16);
        infof("tests passed");
}
```

```d
void main(string[] args)
{
    import std.file:readText;
    import std.stdio:writeln,writefln;
    auto code = readText(args[1]);
    writeln(compile(code));
    f = Scope("std::vector<double>");
    writeln(f.getAllCppNames);
    foreach(m;f.dataMembers)
        {
                writeln(m.name);
                writeln(m.type);
                writeln(m.offset);
        }
        foreach(m;f.getMethods)
        {
                writeln(m.name);
                writeln(m.fullName);
                writeln(m.mangledName);
                writeln(m.signature);
                writeln(m.resultType);
        }
}
}
```

output:
```
1
["assign", "at", "back", "begin", "capacity", "cbegin", "cend", "clear", "crbegin", "crend", "data", "emplace", "emplace_back", "empty", "end", "erase", "front", "insert", "max_size", "pop_back", "push_back", "rbegin", "rend", "reserve", "resize", "shrink_to_fit", "size", "swap", "vector<double>"]
_S_nothrow_relocate
_S_nothrow_relocate
_ZNSt6vectorIdSaIdEE19_S_nothrow_relocateESt17integral_constantIbLb1EE
(true_type)
bool
_S_nothrow_relocate
_S_nothrow_relocate
_ZNSt6vectorIdSaIdEE19_S_nothrow_relocateESt17integral_constantIbLb0EE
(false_type)
bool
_S_use_relocate
_S_use_relocate
_ZNSt6vectorIdSaIdEE15_S_use_relocateEv
()
bool
_S_do_relocate
_S_do_relocate
_ZNSt6vectorIdSaIdEE14_S_do_relocateEPdS2_S2_RS0_St17integral_constantIbLb1EE
(vector<double>::pointer,vector<double>::pointer,vector<double>::pointer,vector<double>::_Tp_alloc_type&,true_type)
double*
_S_do_relocate
_S_do_relocate
_ZNSt6vectorIdSaIdEE14_S_do_relocateEPdS2_S2_RS0_St17integral_constantIbLb0EE
(vector<double>::pointer,vector<double>::pointer,vector<double>::pointer,vector<double>::_Tp_alloc_type&,false_type)
double*
_S_relocate
_S_relocate
_ZNSt6vectorIdSaIdEE11_S_relocateEPdS2_S2_RS0_
(vector<double>::pointer,vector<double>::pointer,vector<double>::pointer,vector<double>::_Tp_alloc_type&)
double*
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1Ev
()
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1ERKS0_
(const vector<double>::allocator_type&)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1EmRKS0_
(vector<const TMVA::Event*>::size_type,const vector<double>::allocator_type&)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1EmRKdRKS0_
(vector<const TMVA::Event*>::size_type,const vector<double>::value_type&,const vector<double>::allocator_type&)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1ERKS1_
(const vector<double>&)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1EOS1_
(vector<double>&&)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1ERKS1_RKS0_
(const vector<double>&,const vector<double>::allocator_type&)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1EOS1_RKS0_St17integral_constantIbLb1EE
(vector<double>&&,const vector<double>::allocator_type&,true_type)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1EOS1_RKS0_St17integral_constantIbLb0EE
(vector<double>&&,const vector<double>::allocator_type&,false_type)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1EOS1_RKS0_
(vector<double>&&,const vector<double>::allocator_type&)
constructor
vector
vector<double>
_ZNSt6vectorIdSaIdEEC1ESt16initializer_listIdERKS0_
(initializer_list<vector<double>::value_type>,const vector<double>::allocator_type&)
constructor
~vector
~vector<double>
_ZNSt6vectorIdSaIdEED0Ev
()
void
operator=
operator=
_ZNSt6vectorIdSaIdEEaSERKS1_
(const vector<double>&)
vector<double>&
operator=
operator=
_ZNSt6vectorIdSaIdEEaSEOS1_
(vector<double>&&)
vector<double>&
operator=
operator=
_ZNSt6vectorIdSaIdEEaSESt16initializer_listIdE
(initializer_list<vector<double>::value_type>)
vector<double>&
assign
assign
_ZNSt6vectorIdSaIdEE6assignEmRKd
(vector<const TMVA::Event*>::size_type,const vector<double>::value_type&)
void
assign
assign
_ZNSt6vectorIdSaIdEE6assignESt16initializer_listIdE
(initializer_list<vector<double>::value_type>)
void
begin
begin
_ZNSt6vectorIdSaIdEE5beginEv
()
__gnu_cxx::__normal_iterator<double*,vector<double> >
begin
begin
_ZNKSt6vectorIdSaIdEE5beginEv
()
__gnu_cxx::__normal_iterator<const double*,vector<double> >
end
end
_ZNSt6vectorIdSaIdEE3endEv
()
__gnu_cxx::__normal_iterator<double*,vector<double> >
end
end
_ZNKSt6vectorIdSaIdEE3endEv
()
__gnu_cxx::__normal_iterator<const double*,vector<double> >
rbegin
rbegin
_ZNSt6vectorIdSaIdEE6rbeginEv
()
reverse_iterator<__gnu_cxx::__normal_iterator<double*,vector<double> > >
rbegin
rbegin
_ZNKSt6vectorIdSaIdEE6rbeginEv
()
reverse_iterator<__gnu_cxx::__normal_iterator<const double*,vector<double> > >
rend
rend
_ZNSt6vectorIdSaIdEE4rendEv
()
reverse_iterator<__gnu_cxx::__normal_iterator<double*,vector<double> > >
rend
rend
_ZNKSt6vectorIdSaIdEE4rendEv
()
reverse_iterator<__gnu_cxx::__normal_iterator<const double*,vector<double> > >
cbegin
cbegin
_ZNKSt6vectorIdSaIdEE6cbeginEv
()
__gnu_cxx::__normal_iterator<const double*,vector<double> >
cend
cend
_ZNKSt6vectorIdSaIdEE4cendEv
()
__gnu_cxx::__normal_iterator<const double*,vector<double> >
crbegin
crbegin
_ZNKSt6vectorIdSaIdEE7crbeginEv
()
reverse_iterator<__gnu_cxx::__normal_iterator<const double*,vector<double> > >
crend
crend
_ZNKSt6vectorIdSaIdEE5crendEv
()
reverse_iterator<__gnu_cxx::__normal_iterator<const double*,vector<double> > >
size
size
_ZNKSt6vectorIdSaIdEE4sizeEv
()
unsigned long
max_size
max_size
_ZNKSt6vectorIdSaIdEE8max_sizeEv
()
unsigned long
resize
resize
_ZNSt6vectorIdSaIdEE6resizeEm
(vector<const TMVA::Event*>::size_type)
void
resize
resize
_ZNSt6vectorIdSaIdEE6resizeEmRKd
(vector<const TMVA::Event*>::size_type,const vector<double>::value_type&)
void
shrink_to_fit
shrink_to_fit
_ZNSt6vectorIdSaIdEE13shrink_to_fitEv
()
void
capacity
capacity
_ZNKSt6vectorIdSaIdEE8capacityEv
()
unsigned long
empty
empty
_ZNKSt6vectorIdSaIdEE5emptyEv
()
bool
reserve
reserve
_ZNSt6vectorIdSaIdEE7reserveEm
(vector<const TMVA::Event*>::size_type)
void
operator[]
operator[]
_ZNSt6vectorIdSaIdEEixEm
(vector<const TMVA::Event*>::size_type)
double&
operator[]
operator[]
_ZNKSt6vectorIdSaIdEEixEm
(vector<const TMVA::Event*>::size_type)
const double&
_M_range_check
_M_range_check
_ZNKSt6vectorIdSaIdEE14_M_range_checkEm
(vector<const TMVA::Event*>::size_type)
void
at
at
_ZNSt6vectorIdSaIdEE2atEm
(vector<const TMVA::Event*>::size_type)
double&
at
at
_ZNKSt6vectorIdSaIdEE2atEm
(vector<const TMVA::Event*>::size_type)
const double&
front
front
_ZNSt6vectorIdSaIdEE5frontEv
()
double&
front
front
_ZNKSt6vectorIdSaIdEE5frontEv
()
const double&
back
back
_ZNSt6vectorIdSaIdEE4backEv
()
double&
back
back
_ZNKSt6vectorIdSaIdEE4backEv
()
const double&
data
data
_ZNSt6vectorIdSaIdEE4dataEv
()
double*
data
data
_ZNKSt6vectorIdSaIdEE4dataEv
()
const double*
push_back
push_back
_ZNSt6vectorIdSaIdEE9push_backERKd
(const vector<double>::value_type&)
void
push_back
push_back
_ZNSt6vectorIdSaIdEE9push_backEOd
(vector<double>::value_type&&)
void
pop_back
pop_back
_ZNSt6vectorIdSaIdEE8pop_backEv
()
void
insert
insert
_ZNSt6vectorIdSaIdEE6insertEN9__gnu_cxx17__normal_iteratorIPKdS1_EERS4_
(vector<double>::const_iterator,const vector<double>::value_type&)
__gnu_cxx::__normal_iterator<double*,vector<double> >
insert
insert
_ZNSt6vectorIdSaIdEE6insertEN9__gnu_cxx17__normal_iteratorIPKdS1_EEOd
(vector<double>::const_iterator,vector<double>::value_type&&)
__gnu_cxx::__normal_iterator<double*,vector<double> >
insert
insert
_ZNSt6vectorIdSaIdEE6insertEN9__gnu_cxx17__normal_iteratorIPKdS1_EESt16initializer_listIdE
(vector<double>::const_iterator,initializer_list<vector<double>::value_type>)
__gnu_cxx::__normal_iterator<double*,vector<double> >
insert
insert
_ZNSt6vectorIdSaIdEE6insertEN9__gnu_cxx17__normal_iteratorIPKdS1_EEmRS4_
(vector<double>::const_iterator,vector<const TMVA::Event*>::size_type,const vector<double>::value_type&)
__gnu_cxx::__normal_iterator<double*,vector<double> >
erase
erase
_ZNSt6vectorIdSaIdEE5eraseEN9__gnu_cxx17__normal_iteratorIPKdS1_EE
(vector<double>::const_iterator)
__gnu_cxx::__normal_iterator<double*,vector<double> >
erase
erase
_ZNSt6vectorIdSaIdEE5eraseEN9__gnu_cxx17__normal_iteratorIPKdS1_EES6_
(vector<double>::const_iterator,vector<double>::const_iterator)
__gnu_cxx::__normal_iterator<double*,vector<double> >
swap
swap
_ZNSt6vectorIdSaIdEE4swapERS1_
(vector<double>&)
void
clear
clear
_ZNSt6vectorIdSaIdEE5clearEv
()
void
_M_fill_initialize
_M_fill_initialize
_ZNSt6vectorIdSaIdEE18_M_fill_initializeEmRKd
(vector<const TMVA::Event*>::size_type,const vector<double>::value_type&)
void
_M_default_initialize
_M_default_initialize
_ZNSt6vectorIdSaIdEE21_M_default_initializeEm
(vector<const TMVA::Event*>::size_type)
void
_M_fill_assign
_M_fill_assign
_ZNSt6vectorIdSaIdEE14_M_fill_assignEmRKd
(vector<const TMVA::Event*>::size_type,const vector<double>::value_type&)
void
_M_fill_insert
_M_fill_insert
_ZNSt6vectorIdSaIdEE14_M_fill_insertEN9__gnu_cxx17__normal_iteratorIPdS1_EEmRKd
(vector<double>::iterator,vector<const TMVA::Event*>::size_type,const vector<double>::value_type&)
void
_M_default_append
_M_default_append
_ZNSt6vectorIdSaIdEE17_M_default_appendEm
(vector<const TMVA::Event*>::size_type)
void
_M_shrink_to_fit
_M_shrink_to_fit
_ZNSt6vectorIdSaIdEE16_M_shrink_to_fitEv
()
bool
_M_insert_rval
_M_insert_rval
_ZNSt6vectorIdSaIdEE14_M_insert_rvalEN9__gnu_cxx17__normal_iteratorIPKdS1_EEOd
(vector<double>::const_iterator,vector<double>::value_type&&)
__gnu_cxx::__normal_iterator<double*,vector<double> >
_M_emplace_aux
_M_emplace_aux
_ZNSt6vectorIdSaIdEE14_M_emplace_auxEN9__gnu_cxx17__normal_iteratorIPKdS1_EEOd
(vector<double>::const_iterator,vector<double>::value_type&&)
__gnu_cxx::__normal_iterator<double*,vector<double> >
_M_check_len
_M_check_len
_ZNKSt6vectorIdSaIdEE12_M_check_lenEmPKc
(vector<const TMVA::Event*>::size_type,const char*)
unsigned long
_S_check_init_len
_S_check_init_len
_ZNSt6vectorIdSaIdEE17_S_check_init_lenEmRKS0_
(vector<const TMVA::Event*>::size_type,const vector<double>::allocator_type&)
unsigned long
_S_max_size
_S_max_size
_ZNSt6vectorIdSaIdEE11_S_max_sizeERKS0_
(const vector<double>::_Tp_alloc_type&)
unsigned long
_M_erase_at_end
_M_erase_at_end
_ZNSt6vectorIdSaIdEE15_M_erase_at_endEPd
(vector<double>::pointer)
void
_M_erase
_M_erase
_ZNSt6vectorIdSaIdEE8_M_eraseEN9__gnu_cxx17__normal_iteratorIPdS1_EE
(vector<double>::iterator)
__gnu_cxx::__normal_iterator<double*,vector<double> >
_M_erase
_M_erase
_ZNSt6vectorIdSaIdEE8_M_eraseEN9__gnu_cxx17__normal_iteratorIPdS1_EES5_
(vector<double>::iterator,vector<double>::iterator)
__gnu_cxx::__normal_iterator<double*,vector<double> >
_M_move_assign
_M_move_assign
_ZNSt6vectorIdSaIdEE14_M_move_assignEOS1_St17integral_constantIbLb1EE
(vector<double>&&,true_type)
void
_M_move_assign
_M_move_assign
_ZNSt6vectorIdSaIdEE14_M_move_assignEOS1_St17integral_constantIbLb0EE
(vector<double>&&,false_type)
void
```
