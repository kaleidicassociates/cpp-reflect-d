


        import core.stdc.config;
        import core.stdc.stdarg: va_list;
        static import core.simd;

        template __from(string moduleName) {
            mixin("import from = " ~ moduleName ~ ";");
        }
        struct DppOffsetSize{ long offset; long size; }
        struct Int128 { long lower; long upper; }
        struct UInt128 { ulong lower; ulong upper; }

        struct __locale_data { int dummy; }


alias _Bool = bool;
struct dpp {

    static bool isEmpty(T)() {
        return T.tupleof.length == 0;
    }
    static struct Move(T) {
        T* ptr;
    }

    static auto move(T)(ref T value) {
        return Move!T(&value);
    }
    mixin template EnumD(string name, T, string prefix) if(is(T == enum)) {
        private static string _memberMixinStr(string member) {
            import std.conv: text;
            import std.array: replace;
            return text(` `, member.replace(prefix, ""), ` = `, T.stringof, `.`, member, `,`);
        }
        private static string _enumMixinStr() {
            import std.array: join;
            string[] ret;
            ret ~= "enum " ~ name ~ "{";
            static foreach(member; __traits(allMembers, T)) {
                ret ~= _memberMixinStr(member);
            }
            ret ~= "}";
            return ret.join("\n");
        }
        mixin(_enumMixinStr());
    }
}

extern(C)
{
    alias wchar_t = int;
    alias size_t = c_ulong;
    alias ptrdiff_t = c_long;
    struct max_align_t
    {
        @DppOffsetSize(0,8) long __clang_max_align_nonce1;
        @DppOffsetSize(16,16) real __clang_max_align_nonce2;
    }
    alias uintmax_t = c_ulong;
    alias intmax_t = c_long;
    alias uintptr_t = c_ulong;
    alias intptr_t = c_long;
    alias uint_fast64_t = c_ulong;
    alias uint_fast32_t = c_ulong;
    alias uint_fast16_t = c_ulong;
    alias uint_fast8_t = ubyte;
    alias int_fast64_t = c_long;
    alias int_fast32_t = c_long;
    alias int_fast16_t = c_long;
    alias int_fast8_t = byte;
    alias uint_least64_t = c_ulong;
    alias uint_least32_t = uint;
    alias uint_least16_t = ushort;
    alias uint_least8_t = ubyte;
    alias int_least64_t = c_long;
    alias int_least32_t = int;
    alias int_least16_t = short;
    alias int_least8_t = byte;
    alias __sig_atomic_t = int;
    alias __socklen_t = uint;
    alias __intptr_t = c_long;
    alias __caddr_t = char*;
    alias __loff_t = c_long;
    alias __syscall_ulong_t = c_ulong;
    alias __syscall_slong_t = c_long;
    alias __ssize_t = c_long;
    alias __fsword_t = c_long;
    alias __fsfilcnt64_t = c_ulong;
    alias __fsfilcnt_t = c_ulong;
    alias __fsblkcnt64_t = c_ulong;
    alias __fsblkcnt_t = c_ulong;
    alias __blkcnt64_t = c_long;
    alias __blkcnt_t = c_long;
    alias __blksize_t = c_long;
    alias __timer_t = void*;
    alias __clockid_t = int;
    alias __key_t = int;
    alias __daddr_t = int;
    alias __suseconds_t = c_long;
    alias __useconds_t = uint;
    alias __time_t = c_long;
    alias __id_t = uint;
    alias __rlim64_t = c_ulong;
    alias __rlim_t = c_ulong;
    alias __clock_t = c_long;
    struct __fsid_t
    {
        @DppOffsetSize(0,8) int[2] __val;
    }
    alias __pid_t = int;
    alias __off64_t = c_long;
    alias __off_t = c_long;
    alias __nlink_t = c_ulong;
    alias __mode_t = uint;
    alias __ino64_t = c_ulong;
    alias __ino_t = c_ulong;
    alias __gid_t = uint;
    alias __uid_t = uint;
    alias __dev_t = c_ulong;
    alias __uintmax_t = c_ulong;
    alias __intmax_t = c_long;
    alias __u_quad_t = c_ulong;
    alias __quad_t = c_long;
    alias __uint_least64_t = c_ulong;
    alias __int_least64_t = c_long;
    alias __uint_least32_t = uint;
    alias __int_least32_t = int;
    alias __uint_least16_t = ushort;
    alias __int_least16_t = short;
    alias __uint_least8_t = ubyte;
    alias __int_least8_t = byte;
    alias __uint64_t = c_ulong;
    alias __int64_t = c_long;
    alias __uint32_t = uint;
    alias __int32_t = int;
    alias __uint16_t = ushort;
    alias __int16_t = short;
    alias __uint8_t = ubyte;
    alias __int8_t = byte;
    alias __u_long = c_ulong;
    alias __u_int = uint;
    alias __u_short = ushort;
    alias __u_char = ubyte;
    alias uint64_t = ulong;
    alias uint32_t = uint;
    alias uint16_t = ushort;
    alias uint8_t = ubyte;
    alias int64_t = c_long;
    alias int32_t = int;
    alias int16_t = short;
    alias int8_t = byte;
    alias Unsigned = c_ulong;
    alias Signed = c_long;
    void cppyy_vectorbool_setitem(void*, int, int) @nogc nothrow;
    int cppyy_vectorbool_getitem(void*, int) @nogc nothrow;
    void cppyy_double2longdouble(double, void*) @nogc nothrow;
    double cppyy_longdouble2double(void*) @nogc nothrow;
    alias cppyy_scope_t = c_ulong;
    alias cppyy_type_t = c_ulong;
    alias cppyy_object_t = void*;
    alias cppyy_method_t = c_long;
    alias cppyy_index_t = c_ulong;
    alias cppyy_funcaddr_t = void*;
    alias cppyy_exctype_t = c_ulong;
    int cppyy_compile(const(char)*) @nogc nothrow;
    char* cppyy_resolve_name(const(char)*) @nogc nothrow;
    char* cppyy_resolve_enum(const(char)*) @nogc nothrow;
    c_ulong cppyy_get_scope(const(char)*) @nogc nothrow;
    c_ulong cppyy_actual_class(c_ulong, void*) @nogc nothrow;
    c_ulong cppyy_size_of_klass(c_ulong) @nogc nothrow;
    c_ulong cppyy_size_of_type(const(char)*) @nogc nothrow;
    void* cppyy_allocate(c_ulong) @nogc nothrow;
    void cppyy_deallocate(c_ulong, void*) @nogc nothrow;
    void* cppyy_construct(c_ulong) @nogc nothrow;
    void cppyy_destruct(c_ulong, void*) @nogc nothrow;
    void cppyy_call_v(c_long, void*, int, void*) @nogc nothrow;
    ubyte cppyy_call_b(c_long, void*, int, void*) @nogc nothrow;
    char cppyy_call_c(c_long, void*, int, void*) @nogc nothrow;
    short cppyy_call_h(c_long, void*, int, void*) @nogc nothrow;
    int cppyy_call_i(c_long, void*, int, void*) @nogc nothrow;
    c_long cppyy_call_l(c_long, void*, int, void*) @nogc nothrow;
    long cppyy_call_ll(c_long, void*, int, void*) @nogc nothrow;
    float cppyy_call_f(c_long, void*, int, void*) @nogc nothrow;
    double cppyy_call_d(c_long, void*, int, void*) @nogc nothrow;
    real cppyy_call_ld(c_long, void*, int, void*) @nogc nothrow;
    double cppyy_call_nld(c_long, void*, int, void*) @nogc nothrow;
    void* cppyy_call_r(c_long, void*, int, void*) @nogc nothrow;
    char* cppyy_call_s(c_long, void*, int, void*, c_ulong*) @nogc nothrow;
    void* cppyy_constructor(c_long, c_ulong, int, void*) @nogc nothrow;
    void cppyy_destructor(c_ulong, void*) @nogc nothrow;
    void* cppyy_call_o(c_long, void*, int, void*, c_ulong) @nogc nothrow;
    void* cppyy_function_address(c_long) @nogc nothrow;
    void* cppyy_allocate_function_args(int) @nogc nothrow;
    void cppyy_deallocate_function_args(void*) @nogc nothrow;
    c_ulong cppyy_function_arg_sizeof() @nogc nothrow;
    c_ulong cppyy_function_arg_typeoffset() @nogc nothrow;
    int cppyy_is_namespace(c_ulong) @nogc nothrow;
    int cppyy_is_template(const(char)*) @nogc nothrow;
    int cppyy_is_abstract(c_ulong) @nogc nothrow;
    int cppyy_is_enum(const(char)*) @nogc nothrow;
    const(char)** cppyy_get_all_cpp_names(c_ulong, c_ulong*) @nogc nothrow;
    c_ulong* cppyy_get_using_namespaces(c_ulong) @nogc nothrow;
    char* cppyy_final_name(c_ulong) @nogc nothrow;
    char* cppyy_scoped_final_name(c_ulong) @nogc nothrow;
    int cppyy_has_complex_hierarchy(c_ulong) @nogc nothrow;
    int cppyy_num_bases(c_ulong) @nogc nothrow;
    char* cppyy_base_name(c_ulong, int) @nogc nothrow;
    int cppyy_is_subtype(c_ulong, c_ulong) @nogc nothrow;
    int cppyy_smartptr_info(const(char)*, c_ulong*, c_long*) @nogc nothrow;
    void cppyy_add_smartptr_type(const(char)*) @nogc nothrow;
    c_long cppyy_base_offset(c_ulong, c_ulong, void*, int) @nogc nothrow;
    int cppyy_num_methods(c_ulong) @nogc nothrow;
    c_ulong* cppyy_method_indices_from_name(c_ulong, const(char)*) @nogc nothrow;
    c_long cppyy_get_method(c_ulong, c_ulong) @nogc nothrow;
    char* cppyy_method_name(c_long) @nogc nothrow;
    char* cppyy_method_full_name(c_long) @nogc nothrow;
    char* cppyy_method_mangled_name(c_long) @nogc nothrow;
    char* cppyy_method_result_type(c_long) @nogc nothrow;
    int cppyy_method_num_args(c_long) @nogc nothrow;
    int cppyy_method_req_args(c_long) @nogc nothrow;
    char* cppyy_method_arg_name(c_long, int) @nogc nothrow;
    char* cppyy_method_arg_type(c_long, int) @nogc nothrow;
    char* cppyy_method_arg_default(c_long, int) @nogc nothrow;
    char* cppyy_method_signature(c_long, int) @nogc nothrow;
    char* cppyy_method_signature_max(c_long, int, int) @nogc nothrow;
    char* cppyy_method_prototype(c_ulong, c_long, int) @nogc nothrow;
    int cppyy_is_const_method(c_long) @nogc nothrow;
    int get_num_templated_methods(c_ulong) @nogc nothrow;
    char* get_templated_method_name(c_ulong, c_ulong) @nogc nothrow;
    int cppyy_exists_method_template(c_ulong, const(char)*) @nogc nothrow;
    int cppyy_method_is_template(c_ulong, c_ulong) @nogc nothrow;
    c_long cppyy_get_method_template(c_ulong, const(char)*, const(char)*) @nogc nothrow;
    c_ulong cppyy_get_global_operator(c_ulong, c_ulong, c_ulong, const(char)*) @nogc nothrow;
    int cppyy_is_publicmethod(c_long) @nogc nothrow;
    int cppyy_is_constructor(c_long) @nogc nothrow;
    int cppyy_is_destructor(c_long) @nogc nothrow;
    int cppyy_is_staticmethod(c_long) @nogc nothrow;
    int cppyy_num_datamembers(c_ulong) @nogc nothrow;
    char* cppyy_datamember_name(c_ulong, int) @nogc nothrow;
    char* cppyy_datamember_type(c_ulong, int) @nogc nothrow;
    c_long cppyy_datamember_offset(c_ulong, int) @nogc nothrow;
    int cppyy_datamember_index(c_ulong, const(char)*) @nogc nothrow;
    int cppyy_is_publicdata(c_ulong, c_ulong) @nogc nothrow;
    int cppyy_is_staticdata(c_ulong, c_ulong) @nogc nothrow;
    int cppyy_is_const_data(c_ulong, c_ulong) @nogc nothrow;
    int cppyy_is_enum_data(c_ulong, c_ulong) @nogc nothrow;
    int cppyy_get_dimension_size(c_ulong, c_ulong, int) @nogc nothrow;
    long cppyy_strtoll(const(char)*) @nogc nothrow;
    ulong cppyy_strtoull(const(char)*) @nogc nothrow;
    void cppyy_free(void*) @nogc nothrow;
    void* cppyy_charp2stdstring(const(char)*, c_ulong) @nogc nothrow;
    const(char)* cppyy_stdstring2charp(void*, c_ulong*) @nogc nothrow;
    void* cppyy_stdstring2stdstring(void*) @nogc nothrow;






    enum DPP_ENUM__DARWIN_C_SOURCE = 1;


    enum DPP_ENUM__FILE_OFFSET_BITS = 64;


    enum DPP_ENUM__GNU_SOURCE = 1;


    enum DPP_ENUM__LARGEFILE_SOURCE = 1;


    enum DPP_ENUM__NETBSD_SOURCE = 1;


    enum DPP_ENUM___BSD_VISIBLE = 1;


    enum DPP_ENUM___XSI_VISIBLE = 700;
    enum DPP_ENUM___GLIBC_USE_LIB_EXT2 = 0;


    enum DPP_ENUM___GLIBC_USE_IEC_60559_BFP_EXT = 0;


    enum DPP_ENUM___GLIBC_USE_IEC_60559_FUNCS_EXT = 0;


    enum DPP_ENUM___GLIBC_USE_IEC_60559_TYPES_EXT = 0;


    enum DPP_ENUM__BITS_STDINT_INTN_H = 1;


    enum DPP_ENUM__BITS_STDINT_UINTN_H = 1;


    enum DPP_ENUM__BITS_TIME64_H = 1;






    enum DPP_ENUM__BITS_TYPES_H = 1;
    enum DPP_ENUM__BITS_TYPESIZES_H = 1;
    enum DPP_ENUM___OFF_T_MATCHES_OFF64_T = 1;


    enum DPP_ENUM___INO_T_MATCHES_INO64_T = 1;


    enum DPP_ENUM___RLIM_T_MATCHES_RLIM64_T = 1;


    enum DPP_ENUM___FD_SETSIZE = 1024;


    enum DPP_ENUM__BITS_WCHAR_H = 1;






    enum DPP_ENUM___WORDSIZE = 64;


    enum DPP_ENUM___WORDSIZE_TIME64_COMPAT32 = 1;


    enum DPP_ENUM___SYSCALL_WORDSIZE = 64;


    enum DPP_ENUM__FEATURES_H = 1;
    enum DPP_ENUM__DEFAULT_SOURCE = 1;


    enum DPP_ENUM___USE_ISOC11 = 1;


    enum DPP_ENUM___USE_ISOC99 = 1;


    enum DPP_ENUM___USE_ISOC95 = 1;


    enum DPP_ENUM___USE_POSIX_IMPLICITLY = 1;


    enum DPP_ENUM__POSIX_SOURCE = 1;




    enum DPP_ENUM___USE_POSIX = 1;


    enum DPP_ENUM___USE_POSIX2 = 1;


    enum DPP_ENUM___USE_POSIX199309 = 1;


    enum DPP_ENUM___USE_POSIX199506 = 1;


    enum DPP_ENUM___USE_XOPEN2K = 1;


    enum DPP_ENUM___USE_XOPEN2K8 = 1;


    enum DPP_ENUM__ATFILE_SOURCE = 1;


    enum DPP_ENUM___USE_MISC = 1;


    enum DPP_ENUM___USE_ATFILE = 1;


    enum DPP_ENUM___USE_FORTIFY_LEVEL = 0;


    enum DPP_ENUM___GLIBC_USE_DEPRECATED_GETS = 0;


    enum DPP_ENUM___GLIBC_USE_DEPRECATED_SCANF = 0;


    enum DPP_ENUM___GNU_LIBRARY__ = 6;


    enum DPP_ENUM___GLIBC__ = 2;


    enum DPP_ENUM___GLIBC_MINOR__ = 29;
    enum DPP_ENUM__STDC_PREDEF_H = 1;


    enum DPP_ENUM__STDINT_H = 1;
    enum DPP_ENUM__SYS_CDEFS_H = 1;
    enum DPP_ENUM___glibc_c99_flexarr_available = 1;
    enum DPP_ENUM___HAVE_GENERIC_SELECTION = 1;
}


import std.string:fromStringz,toStringz;


extern(C) void* cppyy_load_dictionary(const char* lib_name);

version(None)
{
 alias cppyy_scope_t = size_t;
 alias cppyy_type_t = size_t;
 alias cppyy_object_t = void*;
 alias cppyy_method_t = int*;
 alias cppyy_index_t = size_t;
 alias cppyy_funcaddr_t = void*;
 alias cppyy_exctype_t = ulong;
}

int compile(string code)
{
 return cppyy_compile(code.toStringz);
}


string resolveName(string cppItemName)
{
    return cppyy_resolve_name(cppItemName.toStringz).safeReturn.fromStringz.idup;
}


string resolveEnum(string enumType)
{
    return cppyy_resolve_enum(enumType.toStringz).safeReturn.fromStringz.idup;
}

size_t sizeOfType(string typeName)
{
 return cppyy_size_of_type(typeName.toStringz);
}

void loadDictionary(string libraryName)
{
 import std.exception:enforce;
 int result = cast(int) cppyy_load_dictionary(libraryName.toStringz);
 enforce(result ==0 || result == 1);
}


final class Class
{
 cppyy_object_t handle;
 cppyy_type_t type;

 this(cppyy_object_t handle, cppyy_type_t type)
 {
  this.handle = handle;
  this.type = type;
 }

 this(cppyy_object_t handle, Type type)
 {
  this.handle = handle;
  this.type = type.handle;
 }

    size_t sizeOf()
 {
  return cppyy_size_of_klass(type);
 }

 static Class allocate(Type type)
 {
  return new Class(cppyy_allocate(type.handle),type.handle);
 }

 static Class construct(Type type)
 {
  return new Class(cppyy_construct(type.handle),type.handle);
 }






 void destruct()
 {
     cppyy_destruct(type,handle);
 }

 void deallocate()
 {
     cppyy_deallocate(type,handle);
 }

    Type actualClass()
 {
  return Type(cppyy_actual_class(type,handle));
 }

 void call(T,Args...)(Method method, Args args)
 if (is(T==void))
 {
  import std.conv:to;
     cppyy_call_v(method.handle,this.handle,args.length.to!int,args.getClingAgrs());
 }

    ubyte call(T,Args...)(Method method, Args args)
 if (is(T==ubyte))
 {
  import std.conv:to;
  return cast(ubyte) cppyy_call_b(method.handle,this.handle,args.length.to!int,args.getClingArgs());
 }
 char call(T,Args...)(Method method, Args args)
 if (is(T==char))
 {
  import std.conv:to;
  return cppyy_call_c(method.handle,this.handle,args.length.to!int,args.getClingArgs());
 }

 short call(T,Args...)(Method method, Args agrs)
 if (is(T==short))
 {
  import std.conv:to;
  return cppyy_call_h(method.handle,this.handle,args.length.to!int,args.getClingArgs());
 }

 int call(T,Args...)(Method method, Args args)
 if (is(T==int))
 {
  import std.conv:to;
  return cppyy_call_i(method.handle,this.handle,args.length.to!int,args.getClingArgs());
 }

 long call(T,Args...)(Method method, Args args)
 if (is(T==long))
 {
  import std.conv:to;
  return cppyy_call_ll(method.handle,this.handle,args.length.to!int,args.getClingArgs());
 }

 float call(T,Args...)(Method method, Args agrs)
 if (is(T==float))
 {
  import std.conv:to;
     return cppyy_call_f(method.handle,this.handle,args.length.to!int,args.getClingArgs());
 }

    double call(T,Args...)(Method method, Args args)
 if (is(T==double))
 {
  import std.conv:to;
  return cppyy_call_d(method.handle,args.length.to!int,args.getClingArgs());
 }






 void* call(T,Args...)(Method method, Args agrs)
 if (is(T==void*))
 {
  import std.conv:to;
  return cppyy_call_r(method.handle,this.handle,args.length.to!int,args.getClingArgs());
 }

 cpyy_object_t call(T,Args...)(Method method, Type resultType, Args args)
 if (is(T==cpyy_object_t))
 {
  import std.conv:to;
  return cppyy_call_o(method.handle,this.handle,args.length.to!int,args.getClingArgs(),resultType);
 }

 Class call(T,Args...)(Method method, Type resultType, Args args)
 if (is(T == Class))
 {
  import std.conv:to;
  return new Class(cppyy_call_o(method.handle,this.handle,args.length.to!int,args.getClingArgs(),resultType),type);
 }

 string call(T,Args...)(Method method, Args args)
 if (is(T==string))
 {
  import std.conv:to;
  size_t len;
     auto p = cppyy_call_s(method.handle,handle,args.length.to!int,args.getClingArgs(),&len);
  return p[0..len].idup;
 }

 static Class constructor(Args...)(Method method, Args args)
 {
  return new Class(cppyy_constructor(method.handle,this.handle,args.length,args.getClingArgs()));
 }

 void destructor()
 {
  cppyy_destructor(this.type,handle);
 }

   /+
    cppyy_funcaddr_t getFunctionAddressFromIndex(long index)
 {
  return cppyy_function_address_from_index(cast(ulong)this.handle,index);
 }
+/
}

struct Parameter
{
 union Value
 {
  int boolean;
  short short_;
  ushort ushort_;
  int int_;
  uint uint_;
  int long_;
  uint ulong_;
  long longlong_;
  ulong ulonglong;
  float float_;
  double double_;
  double longdouble;
  void* p;
 }

 Value value;
 void* fRef;
 TypeCode typeCode;

 this(bool b)
 {
  this.value.boolean = b ? 1 : 0;
  this.typeCode = TypeCode.boolean;
 }
 this(short s)
 {
  this.value.short_ = s;
  this.typeCode = TypeCode.short_;
 }
 this(ushort u)
 {
  this.value.ushort_ = u;
  this.typeCode = TypeCode.ushort_;
 }
 this(int i)
 {
  this.value.int_ = i;
  this.typeCode = TypeCode.int_;
 }
 this(uint u)
 {
  this.value.uint_ = u;
  this.typeCode = TypeCode.uint_;
 }
 this(long l)
 {
  this.value.longlong_ = l;
  this.typeCode = TypeCode.longlong;
 }
 this(ulong u)
 {
  this.value.ulonglong = u;
  this.typeCode = TypeCode.ulonglong;
 }
 this(float f)
 {
  this.value.float_ = f;
  this.typeCode = TypeCode.float_;
 }
 this(double f)
 {
  this.value.double_ = f;
  this.typeCode = TypeCode.double_;
 }
 this(void* p)
 {
  this.value.p = p;
  this.typeCode = TypeCode.void1;
 }
 this(T)(ref T x)
 {
  this.value.fRef = cast(void*) &x;
  this.typeCode = TypeCode.ref_;
 }
 this(T)(ref const(T) x)
 {
  this.value.fRef = cast(void*) *x;
  this.typeCode = TypeCode.ref_;
 }
 this(T)(T* t)
 {
  this.value.p = cast(void*) t;
  this.typeCode = TypeCode.void1;
 }
}

enum TypeCode : char
{
 boolean = 'b',
 short_ = 'h',
 ushort_ = 'H',
 int_ = 'i',
 uint_ = 'I',
 long_ = 'l',
 ulong_ = 'L',
 longlong = 'q',
 ulonglong = 'Q',
 float_ = 'f',
 double_ = 'd',
 longdouble = 'g',
 void1 = 'a',
 void2 = 'o',
 void3 = 'p',
 refRelease = 'X',
 ref_ = 'V',
 constRef = 'r',
}

final class ClingArgs
{
 Parameter[] params;

 ubyte[] buf;

 this()
 {
 }

 void* handle()
 {
  return cast(void*) buf.ptr;
 }

 alias handle this;

 cppyy_exctype_t * pException()
 {
  return cast(cppyy_exctype_t*)(handle+params.length * Parameter.sizeof);
 }

 char** pExceptionMessage()
 {
  return cast(char**)(handle+params.length * Parameter.sizeof + (cppyy_exctype_t*).sizeof);
 }

 void setBuf()
 {
  import std.array:Appender;
  import std.range:repeat;
  import std.array:array;
  Appender!(ubyte[]) buf;
  foreach(param;params)
   buf.put((cast(ubyte*)&param)[0..Parameter.sizeof]);
  buf.put((cast(ubyte)0).repeat(cppyy_exctype_t.sizeof).array);
  buf.put((cast(ubyte)0).repeat((char**).sizeof).array);
  this.buf = buf.data;
 }

 this(Args...)(Args args)
 {
  foreach(i,arg;args)
  {
   params ~= Parameter(arg);
  }
  setBuf();
 }

 cppyy_exctype_t exceptionType()
 {
  return *pException();
 }

 string exceptionString()
 {
  auto s = pExceptionMessage();
  return (s is null || *s is null) ? "" : (*s).fromStringz.idup;
 }
}

ClingArgs getClingArgs(Args...)(Args args)
{
 return new ClingArgs(args);
}

void* allocateFunctionArgs(int numArgs)
{
 return cppyy_allocate_function_args(numArgs);
}

void deallocateFunctionArgs(void* args)
{
 cppyy_deallocate_function_args(args);
}

size_t functionArgSizeof()
{
 return cppyy_function_arg_sizeof();
}

size_t functionArgTypeOffset()
{
 return cppyy_function_arg_typeoffset();
}


bool isTemplate(string templateName)
{
    return (cppyy_is_template(templateName.toStringz)!=0);
}

T* safeReturn(T)(T* handle)
{
 import std.exception;
 enforce(handle!is null);
 return handle;
}

struct Type
{
 cppyy_type_t handle;

    size_t sizeOf()
 {
  return cppyy_size_of_klass(handle);
 }

 bool isAbstract()
 {
  return (cppyy_is_abstract(handle)!=0);
 }

 static bool isEnum(string typeName)
 {
     return (cppyy_is_enum(typeName.toStringz)!=0);
 }


 string finalName()
 {
     return cppyy_final_name(handle).safeReturn.fromStringz.idup;
 }

    string scopedFinalName()
 {
  return cppyy_scoped_final_name(handle).fromStringz.idup;
 }

 bool hasComplexHierarchy()
 {
     return (cppyy_has_complex_hierarchy(handle)!=0);
 }

    int numBases()
 {
  return cppyy_num_bases(handle);
 }

 string baseName(int baseIndex)
 {
     return cppyy_base_name(handle,baseIndex).fromStringz.idup;
 }

    bool isSubtype(Type base)
 {
  return (cppyy_is_subtype(this.handle,base.handle)!=0);
 }

 Class constructor(Args...)(Method method,Args args)
 {
     Class ret;
  ret.handle = cppyy_constructor(method.handle,handle,args.length,&args[0]);
  ret.type = handle;
  return ret;
 }
}

auto smartPtrInfo(string name)
{
 import std.typecons:tuple;
 Type rawType;
 Method derefMethod;
    auto ret = cppyy_smartptr_info(name.toStringz,&rawType.handle,&derefMethod.handle);
 return tuple(ret,rawType,derefMethod);
}

void addSmartPtrType(string typeName)
{
    cppyy_add_smartptr_type(typeName.toStringz);
}


struct Scope
{
 cppyy_scope_t handle;

 this(string scopeName)
 {
  this.handle = cppyy_get_scope(scopeName.toStringz);
 }

    cppyy_index_t* getUsingNamespaces()
 {
  return cppyy_get_using_namespaces(handle);
 }
    string[] getAllCppNames()
 {
  string[] ret;
  size_t count;
  const(char)** p = cppyy_get_all_cpp_names(handle,&count);
  foreach(entry;p[0..count])
  {
   ret ~= entry.fromStringz.idup;
  }
  return ret;
 }

    bool isNamespace()
 {
  return (cppyy_is_namespace(handle)!=0);
 }
/+
 int numTemplatedMethods()
 {
     return cppyy_get_num_templated_methods(handle);
 }
+/
    int numDataMembers()
 {
  return cppyy_num_datamembers(handle);
 }

    int dataMemberIndex(string name)
 {
  return cppyy_datamember_index(handle,name.toStringz);
 }

 DataMember dataMember(string name)
 {
  return DataMember(handle,this.dataMemberIndex(name));
 }

 DataMember[] dataMembers()
 {
  import std.array:Appender;
  Appender!(DataMember[]) ret;
  foreach(i;0..numDataMembers())
  {
   ret.put(DataMember(handle,cast(int)i));
  }
  return ret.data;
 }

 bool isPublicData(string name)
 {
  return (cppyy_is_publicdata(handle,dataMemberIndex(name))!=0);
 }
    bool isStaticData(string name)
 {
  return (cppyy_is_staticdata(handle,dataMemberIndex(name))!=0);
 }
 bool isConstData(string name)
 {
     return (cppyy_is_const_data(handle,dataMemberIndex(name))!=0);
 }

 bool isEnumData(string name)
 {
     return (cppyy_is_enum_data(handle,dataMemberIndex(name))!=0);
 }

 string methodPrototype(Method method, bool showFormalArgs)
 {
  return cppyy_method_prototype(handle,method.handle,showFormalArgs ? 1 : 0).fromStringz.idup;
 }

 int numMethods()
 {
  return cppyy_num_methods(handle);
 }

 Method[] getMethods()
 {
  import std.array:Appender;
  Appender!(Method[]) ret;
  foreach(i;0..numMethods())
  {
   ret.put(Method(cppyy_get_method(handle,cast(int)i)));
  }
  return ret.data;
 }

 long[] methodIndices(string name)
 {
  import std.array:Appender;
  Appender!(long[]) buf;
  cppyy_index_t* ret = cppyy_method_indices_from_name(handle,name.toStringz);
  while(ret !is null && *ret!=-1)
   buf.put(*ret++);
  return buf.data;
 }

 Method getMethodFromIndex(long index)
 {
  import std.conv:to;
     return Method(cppyy_get_method(handle,index.to!cppyy_index_t));
 }

 Method[] getMethods(string name)
 {
  import std.algorithm:map;
  import std.array:array;
  return methodIndices(name).map!(m => getMethodFromIndex(m)).array;
 }
/+
 string getTemplatedMethodName(cppyy_index_t index)
 {
     return cppyy_get_templated_method_name(handle,index).fromStringz.idup;
 }
+/
 bool methodIsTemplate(cppyy_index_t index)
 {
  return (cppyy_method_is_template(handle,index)!=0);
 }

 bool existsMethodTemplate(string name)
 {
     return (cppyy_exists_method_template(handle,name.toStringz)!=0);
 }
 Method getMethodTemplate(string name, string proto)
 {
     return Method(cppyy_get_method_template(handle,name.toStringz,proto.toStringz));
 }


    ptrdiff_t offset(Type derived, Type base, bool upCast)
 {
  return cppyy_base_offset(derived.handle,base.handle,cast(void*)this.handle,upCast ? 1: -1);
 }

    cppyy_index_t getGlobalOperator(Scope lc, Scope rc, string op)
 {
  return cppyy_get_global_operator(handle,lc.handle,rc.handle,op.toStringz);
 }

    int getDimensionSize(cppyy_index_t idata, int dimension)
 {
  return cppyy_get_dimension_size(handle,idata,dimension);
 }

    cppyy_funcaddr_t getAddress(Method method)
 {
  return cppyy_function_address(method.handle);
 }
}

struct Method
{
 cppyy_method_t handle;

 bool isPublic()
 {
  return (cppyy_is_publicmethod(handle)!=0);
 }

 bool isConstructor()
 {
  return (cppyy_is_constructor(handle)!=0);
 }

 bool isDestructor()
 {
    return (cppyy_is_destructor(handle)!=0);
 }

 bool isStatic()
 {
  return (cppyy_is_staticmethod(handle)!=0);
 }

 string name()
 {
  return cppyy_method_name(handle).fromStringz.idup;
 }

 string fullName()
 {
     return cppyy_method_full_name(handle).fromStringz.idup;
 }

 string mangledName()
 {
     return cppyy_method_mangled_name(handle).fromStringz.idup;
 }

 string resultType()
 {
  return cppyy_method_result_type(handle).fromStringz.idup;
 }
 int numArgs()
 {
  return cppyy_method_num_args(handle);
 }

 int requiredNumArgs()
 {
  return cppyy_method_req_args(handle);
 }

 string signatureNoFormalArgs()
 {
     return cppyy_method_signature(handle,0).fromStringz.idup;
 }

 string signatureFormalArgs()
 {
     return cppyy_method_signature(handle,1).fromStringz.idup;
 }

 string signatureMaxNoFormalArgs(int maxArgs)
 {
     return cppyy_method_signature_max(handle,0,maxArgs).fromStringz.idup;
 }

 string signatureMaxFormalArgs(int maxArgs)
 {
     return cppyy_method_signature_max(handle,1,maxArgs).fromStringz.idup;
 }

 bool isConst()
 {
     return (cppyy_is_const_method(handle)!=0);
 }

    cppyy_funcaddr_t getAddress()
 {
  return cppyy_function_address(handle);
 }
}

struct MethodArgument
{
 cppyy_method_t handle;
 int index;

 string name()
 {
  return cppyy_method_arg_name(handle,index).fromStringz.idup;
 }

 string type()
 {
  return cppyy_method_arg_type(handle,index).fromStringz.idup;
 }

 string defaultArgument()
 {
     return cppyy_method_arg_default(handle,index).fromStringz.idup;
 }

 string signature(bool showFormalArgs = false)
 {
  return cppyy_method_signature(handle,showFormalArgs?1:0).fromStringz.idup;
 }

 string signatureMax(bool showFormalArgs, int maxArgs)
 {
  return cppyy_method_signature_max(handle,showFormalArgs,maxArgs).fromStringz.idup;
 }
}

struct DataMember
{
 cppyy_scope_t scopeHandle;
 int index;

 string name()
 {
  return cppyy_datamember_name(scopeHandle,index).fromStringz.idup;
 }

 string type()
 {
  return cppyy_datamember_type(scopeHandle,index).fromStringz.idup;
 }

 size_t offset()
 {
  return cppyy_datamember_offset(scopeHandle,index);
 }
}



final class StdString
{
 cppyy_object_t handle;

 this(cppyy_object_t handle)
 {
  this.handle = handle;
 }

 this(string s)
 {
  this.handle = cppyy_charp2stdstring(s.ptr,s.length);
 }

    override string toString()
 {
  size_t len;
  auto p = cppyy_stdstring2charp(handle,&len);
  return p[0..len].idup;
 }

    StdString dup()
 {
     return new StdString(cppyy_stdstring2stdstring(handle));
 }
}

struct StdVectorBool
{
 cppyy_object_t handle;

 bool get(int index)
 {
     return (cppyy_vectorbool_getitem(handle,index)!=0);
 }

 void set(int index, bool value)
 {
     cppyy_vectorbool_setitem(handle,index,value?1:0);
 }
}
