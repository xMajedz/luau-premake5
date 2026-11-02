newoption {
	trigger = "luau-path",
	default = ".",
	description = "sets the path to luau distribution.",
}

LUAU_PREFIX = _OPTIONS["luau-path"]

LUAU_CONFORMANCE_SOURCE_DIR = '\"'.. path.getabsolute(LUAU_PREFIX .. "/tests/conformance") .. '\"'

workspace "Luau"
	language "C++"
	configurations {
		"Debug", "Release"
	}
	location  "%{LUAU_PREFIX}/build"
	objdir    "%{LUAU_PREFIX}/build"
	targetdir "%{LUAU_PREFIX}/build"
	
	filter "configurations:Debug"
	defines {
		"DEBUG"
	}
	symbols "On"

	filter "configurations:Release"
	defines {
		"NDEBUG"
	}
	optimize "On"

project "Luau.Ast"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Ast/include", "%{LUAU_PREFIX}/Common/include",
	}
	files {
		"%{LUAU_PREFIX}/Ast/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauast"

project "Luau.Compiler"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Compiler/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Bytecode/include",
	}
	files {
		"%{LUAU_PREFIX}/Compiler/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luaucompiler"

project "Luau.VM"
	kind "Staticlib"
	cppdialect "C++11"
	includedirs {
		"%{LUAU_PREFIX}/VM/include", "%{LUAU_PREFIX}/Common/include",
	}
	files {
		"%{LUAU_PREFIX}/VM/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauvm"

project "Luau.Config"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Config/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Compiler/include",
		"%{LUAU_PREFIX}/VM/include",
	}
	files {
		"%{LUAU_PREFIX}/Config/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauconfig"

project "Luau.CodeGen"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CodeGen/include", "%{LUAU_PREFIX}/Common/include",

		"%{LUAU_PREFIX}/VM/include", "%{LUAU_PREFIX}/VM/src",
	}
	files {
		"%{LUAU_PREFIX}/CodeGen/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luaucodegen"

project "Luau.Require"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Require/include", "%{LUAU_PREFIX}/Common/include",

		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/VM/include",
		"%{LUAU_PREFIX}/Config/include",
	}
	files {
		"%{LUAU_PREFIX}/Require/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luaurequire"
	
project "Luau.Analysis"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Common/include", "%{LUAU_PREFIX}/Analysis/include",

		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Config/include",
		"%{LUAU_PREFIX}/EqSat/include",
		"%{LUAU_PREFIX}/Compiler/include",
		"%{LUAU_PREFIX}/VM/include",
		"%{LUAU_PREFIX}/Bytecode/include",
	}
	files {
		"%{LUAU_PREFIX}/Analysis/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauanalysis"

project "Luau.EqSat"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Common/include", "%{LUAU_PREFIX}/EqSat/include",
	}
	files {
		"%{LUAU_PREFIX}/EqSat/src/*.cpp",
	}
	
	filter "action:gmake"
	targetname "luaueqsat"

project "Luau.Bytecode"
	kind "StaticLib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Common/include", "%{LUAU_PREFIX}/Bytecode/include",
	}
	files {
		"%{LUAU_PREFIX}/Bytecode/src/*.cpp",
	}
	
	filter "action:gmake"
	targetname "luaubytecode"

project "Luau.Common"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Common/include",	
	}
	files {
		"%{LUAU_PREFIX}/Common/src/*.cpp",
	}
	
	filter "action:gmake"
	targetname "luaucommon"

project "extern.isocline"
	kind "Staticlib"
	language "C"
	includedirs {
		"%{LUAU_PREFIX}/extern/isocline/include"
	}
	files {
		"%{LUAU_PREFIX}/extern/isocline/src/isocline.c"
	}
	
	filter "action:gmake"
	targetname "isocline"

project "Luau.CLI.Lib"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Config/include",
		"%{LUAU_PREFIX}/Ast/include",
	}
	files {
		"%{LUAU_PREFIX}/CLI/src/FileUtils.cpp",
		"%{LUAU_PREFIX}/CLI/src/Flags.cpp",
		"%{LUAU_PREFIX}/CLI/src/VfsNavigator.cpp",
	}
	
project "luau"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Compiler/include",
		"%{LUAU_PREFIX}/Config/include",
		
		"%{LUAU_PREFIX}/VM/include", "%{LUAU_PREFIX}/VM/src",
		
		"%{LUAU_PREFIX}/CodeGen/include",		
		"%{LUAU_PREFIX}/Require/include",
		
		"%{LUAU_PREFIX}/Bytecode/include", "%{LUAU_PREFIX}/Bytecode/src",
		"%{LUAU_PREFIX}/Inliner/include",
		
		"%{LUAU_PREFIX}/extern/isocline/include",
		"%{LUAU_PREFIX}/extern",
	}
	files {
		"%{LUAU_PREFIX}/CLI/src/Profiler.cpp",
		"%{LUAU_PREFIX}/CLI/src/Coverage.cpp",
		"%{LUAU_PREFIX}/CLI/src/Counters.cpp",
		"%{LUAU_PREFIX}/CLI/src/Repl.cpp",
		"%{LUAU_PREFIX}/CLI/src/ReplEntry.cpp",
		"%{LUAU_PREFIX}/CLI/src/ReplRequirer.cpp",
		
		"%{LUAU_PREFIX}/Inliner/src/*.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		"Luau.Bytecode",

		"Luau.Common",
		
		"Luau.Ast",
		
		"Luau.Require",

		"Luau.Config",
		
		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.VM",
		
		"extern.isocline",
	}
	
	filter "action:gmake"
	links { "pthread" }

project "luau-analyze"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Analysis/include",
		"%{LUAU_PREFIX}/EqSat/include",
		"%{LUAU_PREFIX}/Config/include",
		"%{LUAU_PREFIX}/Require/include",
		"%{LUAU_PREFIX}/Require/Navigator/include",
		"%{LUAU_PREFIX}/Bytecode/include",
		"%{LUAU_PREFIX}/VM/include",
		"%{LUAU_PREFIX}/extern",
	}
	files {
		"%{LUAU_PREFIX}/CLI/src/Analyze.cpp",
		"%{LUAU_PREFIX}/CLI/src/AnalyzeRequirer.cpp",
	}
	links {
		"Luau.CLI.Lib",
				
		"Luau.Common",
		
		"Luau.Analysis",

		"Luau.Ast",
		
		"Luau.Require",

		"Luau.Config",
		
		"Luau.EqSat",
		"Luau.Compiler",
		"Luau.VM",
		"Luau.Bytecode",
	}
	
	filter "action:gmake"
	links { "pthread" }

project "luau-ast"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Analysis/include",
	}
	files {
		"%{LUAU_PREFIX}/CLI/src/Ast.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		"Luau.Ast",
		
		"Luau.Common",
			
		"Luau.Config",	
	}

project "luau-reduce"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
	}
	files {
		"%{LUAU_PREFIX}/CLI/src/Reduce.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		"Luau.Ast",
		
		"Luau.Common",
		
		"Luau.Config",	
	}

project "luau-compile"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Compiler/include",
		"%{LUAU_PREFIX}/CodeGen/include",
		"%{LUAU_PREFIX}/VM/include",
		"%{LUAU_PREFIX}/Bytecode/include",
	}
	files {
		"%{LUAU_PREFIX}/CLI/src/Compile.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		"Luau.Bytecode",

		"Luau.Common",
		
		"Luau.Ast",
		
		"Luau.Config",

		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.VM",
	}
	
project "luau-bytecode"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Compiler/include",
		"%{LUAU_PREFIX}/CodeGen/include",
		"%{LUAU_PREFIX}/VM/include",

		"%{LUAU_PREFIX}/Bytecode/include",
	}
	files {
		"%{LUAU_PREFIX}/CLI/src/Bytecode.cpp",
	}
	links {
		"Luau.CLI.LIB",
		
		"Luau.Bytecode",

		"Luau.Common",
		
		"Luau.Ast",
		
		"Luau.Config",
		
		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.VM",
	}

project "luau-tests"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		"%{LUAU_PREFIX}/Common/include",
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Compiler/include",
		"%{LUAU_PREFIX}/Config/include",
		"%{LUAU_PREFIX}/Analysis/include",
		"%{LUAU_PREFIX}/EqSat/include",
		"%{LUAU_PREFIX}/CodeGen/include",
		"%{LUAU_PREFIX}/VM/include", "%{LUAU_PREFIX}/VM/src",
		"%{LUAU_PREFIX}/Require/Runtime/include",
		"%{LUAU_PREFIX}/CLI/include",
		"%{LUAU_PREFIX}/Bytecode/include", "%{LUAU_PREFIX}/Bytecode/src",
		"%{LUAU_PREFIX}/Require/include",
		"%{LUAU_PREFIX}/Inliner/include",

		"%{LUAU_PREFIX}/extern/isocline/include",
		"%{LUAU_PREFIX}/extern",

	}
	files {
		"%{LUAU_PREFIX}/CLI/src/Profiler.cpp",
		"%{LUAU_PREFIX}/CLI/src/Counters.cpp",
		"%{LUAU_PREFIX}/CLI/src/Coverage.cpp",
		"%{LUAU_PREFIX}/CLI/src/Repl.cpp",
		"%{LUAU_PREFIX}/CLI/src/ReplRequirer.cpp",
		
		"%{LUAU_PREFIX}/Inliner/src/*.cpp",

		"%{LUAU_PREFIX}/tests/*.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		"Luau.Analysis",
		"Luau.EqSat",
		"Luau.Compiler",
		"Luau.Ast",
		"Luau.Codegen",
		"Luau.VM",
		"Luau.Require",
		"Luau.Config",
		"Luau.Bytecode",
		"Luau.Common",
		
		"extern.isocline",
	}
	defines {
		"DOCTEST_CONFIG_DOUBLE_STRINGIFY",
		"DOCTEST_CONFIG_USE_STD_HEADERS",
		"LUAU_CONFORMANCE_SOURCE_DIR=%{LUAU_CONFORMANCE_SOURCE_DIR}",
	}
	
	filter "action:gmake"
	targetname "luau-tests"
	links { "pthread" }

project "luau-test-link-vm"
	--kind "None"
	kind "ConsoleApp"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/VM/include"
	}
	files {
		"%{LUAU_PREFIX}/tests/link/Vm.test.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		--"Luau.Ast",
		
		"Luau.Common",
		
		"Luau.Config",
		
		"Luau.VM",
	}

project "luau-test-link-codegen"
	--kind "None"
	kind "ConsoleApp"
	includedirs {
		"%{LUAU_PREFIX}/CLI/include", "%{LUAU_PREFIX}/Common/include",
		
		"%{LUAU_PREFIX}/VM/include",
		"%{LUAU_PREFIX}/CodeGen/include",
	}
	files {
		"%{LUAU_PREFIX}/tests/link/VmCodeGen.test.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		--"Luau.Ast",
		
		"Luau.Common",
		
		"Luau.Config",	
		
		"Luau.VM",
		
		"Luau.Codegen",
	}

project "Luau.Web"
	kind "ConsoleApp"
	includedirs {
		"%{LUAU_PREFIX}/Common/include", "%{LUAU_PREFIX}/Config/include",
		"%{LUAU_PREFIX}/Ast/include",
		"%{LUAU_PREFIX}/Compiler/include",
		"%{LUAU_PREFIX}/VM/include",
		"%{LUAU_PREFIX}/Analysis/include",
	}
	files { 
		"%{LUAU_PREFIX}/CLI/src/Web.cpp",
	}
	links {
		"Luau.Bytecode",
		"Luau.Common",
		"Luau.Ast",
		"Luau.Config",
		"Luau.Compiler",
		"Luau.VM",
		"Luau.Analysis"
	}
	linkoptions {
		"-sEXPORTED_FUNCTIONS=['_executeScript','_checkScript']",
		"-sEXPORTED_RUNTIME_METHODS=['ccall','cwrap']",
		"-fexceptions",
		"-sSINGLE_FILE=1",
	}
	targetextension ".js"

	filter "not system:emscripten"
	kind "None"