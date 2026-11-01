newoption {
	trigger = "luau-path",
	default = ".",
	description = "sets the path to luau distribution.",
}

PREFIX = _OPTIONS["luau-path"] .. "/"

workspace "Luau"
	language "C++"
	configurations {
		"Debug", "Release"
	}
	location "%{PREFIX}build"
	objdir ("%{PREFIX}build")
	targetdir ("%{PREFIX}build")
	
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
		PREFIX .. "Ast/include", PREFIX .. "Common/include",
	}
	files {
		PREFIX .. "Ast/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauast"
	
	buildcommands "echo %{PREFIX}"

project "Luau.Compiler"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Compiler/include", PREFIX .. "Common/include",
		
		PREFIX .. "Ast/include",
		PREFIX .. "Bytecode/include",
	}
	files {
		PREFIX .. "Compiler/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luaucompiler"

project "Luau.VM"
	kind "Staticlib"
	cppdialect "C++11"
	includedirs {
		PREFIX .. "VM/include", PREFIX .. "Common/include",
	}
	files {
		PREFIX .. "VM/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauvm"

project "Luau.Config"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Config/include", PREFIX .. "Common/include",
		
		PREFIX .. "Ast/include",
		PREFIX .. "Compiler/include",
		PREFIX .. "VM/include",
	}
	files {
		PREFIX .. "Config/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauconfig"

project "Luau.CodeGen"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "CodeGen/include", PREFIX .. "Common/include",

		PREFIX .. "VM/include",
		PREFIX .. "VM/src",
	}
	files {
		PREFIX .. "CodeGen/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luaucodegen"

project "Luau.Require"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Require/include", PREFIX .. "Common/include",

		PREFIX .. "Ast/include",
		PREFIX .. "VM/include",
		PREFIX .. "Config/include",
	}
	files {
		PREFIX .. "Require/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luaurequire"
	
project "Luau.Analysis"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Common/include", PREFIX .. "Analysis/include",

		PREFIX .. "Ast/include",
		PREFIX .. "Config/include",
		PREFIX .. "EqSat/include",
		PREFIX .. "Compiler/include",
		PREFIX .. "VM/include",
		PREFIX .. "Bytecode/include",
	}
	files {
		PREFIX .. "Analysis/src/*.cpp"
	}
	
	filter "action:gmake"
	targetname "luauanalysis"

project "Luau.EqSat"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Common/include", PREFIX .. "EqSat/include",
	}
	files {
		PREFIX .. "EqSat/src/*.cpp",
	}
	
	filter "action:gmake"
	targetname "luaueqsat"

project "Luau.Bytecode"
	kind "StaticLib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Common/include", PREFIX .. "Bytecode/include",
	}
	files {
		PREFIX .. "Bytecode/src/*.cpp",
	}
	
	filter "action:gmake"
	targetname "luaubytecode"

project "Luau.Common"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Common/include",	
	}
	files {
		PREFIX .. "Common/src/*.cpp",
	}
	
	filter "action:gmake"
	targetname "luaucommon"

project "extern.isocline"
	kind "Staticlib"
	language "C"
	includedirs {
		PREFIX .. "extern/isocline/include"
	}
	files {
		PREFIX .. "extern/isocline/src/isocline.c"
	}
	
	filter "action:gmake"
	targetname "isocline"

project "Luau.Tests"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "Common/include",
		PREFIX .. "Ast/include",
		PREFIX .. "Compiler/include",
		PREFIX .. "Config/include",
		PREFIX .. "Analysis/include",
		PREFIX .. "EqSat/include",
		PREFIX .. "CodeGen/include",
		PREFIX .. "VM/include",
		PREFIX .. "Require/Runtime/include",
		PREFIX .. "CLI/include",
		PREFIX .. "Bytecode/include",
		PREFIX .. "Require/include",

		PREFIX .. "VM/src",

		PREFIX .. "extern/isocline/include",
		PREFIX .. "extern",

	}
	files {
		PREFIX .. "CLI/src/FileUtils.cpp",
		PREFIX .. "CLI/src/Flags.cpp",
		PREFIX .. "CLI/src/Profiler.cpp",
		PREFIX .. "CLI/src/Coverage.cpp",
		PREFIX .. "CLI/src/Repl.cpp",
		PREFIX .. "CLI/src/ReplRequirer.cpp",
		PREFIX .. "CLI/src/VfsNavigator.cpp",

		PREFIX .. "tests/*.cpp",
	}
	links {
		"Luau.Analysis",
		"Luau.EqSat",
		"Luau.Compiler",
		"Luau.Ast",
		"Luau.Codegen",
		"Luau.VM",
		"Luau.Require",
		"Luau.Requirenavigator",
		"Luau.Config",
		"Luau.Bytecode",
		"Luau.Common",
		
		"extern.isocline",
	}
	defines {
		"DOCTEST_CONFIG_DOUBLE_STRINGIFY"
	}
	
	filter "action:gmake"
	targetname "luau-tests"
	links { "pthread" }

project "Luau.CLI.Lib"
	kind "Staticlib"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "CLI/include", PREFIX .. "Common/include",
		
		PREFIX .. "Config/include",
		PREFIX .. "Ast/include",
	}
	files {
		PREFIX .. "CLI/src/FileUtils.cpp",
		PREFIX .. "CLI/src/Flags.cpp",
		PREFIX .. "CLI/src/VfsNavigator.cpp",
	}
	
project "luau"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "CLI/include", PREFIX .. "Common/include",
		
		PREFIX .. "Ast/include",
		PREFIX .. "Compiler/include",
		PREFIX .. "Config/include",
		PREFIX .. "VM/include",
		PREFIX .. "CodeGen/include",		
		PREFIX .. "Require/include",
		
		PREFIX .. "extern/isocline/include",
		PREFIX .. "extern",
	}
	files {
		PREFIX .. "CLI/src/Profiler.cpp",
		PREFIX .. "CLI/src/Coverage.cpp",
		PREFIX .. "CLI/src/Counters.cpp",
		PREFIX .. "CLI/src/Repl.cpp",
		PREFIX .. "CLI/src/ReplEntry.cpp",
		PREFIX .. "CLI/src/ReplRequirer.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		"Luau.Common",
		
		"Luau.Ast",
		
		"Luau.Require",

		"Luau.Config",
				
		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.VM",
		"Luau.Bytecode",
		
		"extern.isocline",
	}
	
	filter "action:gmake"
	links { "pthread" }

project "luau-analyze"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "CLI/include", PREFIX .. "Common/include",
		
		PREFIX .. "Ast/include",
		PREFIX .. "Analysis/include",
		PREFIX .. "EqSat/include",
		PREFIX .. "Config/include",
		PREFIX .. "Require/include",
		PREFIX .. "Require/Navigator/include",
		PREFIX .. "Bytecode/include",
		PREFIX .. "VM/include",
		PREFIX .. "extern",
	}
	files {
		PREFIX .. "CLI/src/Analyze.cpp",
		PREFIX .. "CLI/src/AnalyzeRequirer.cpp",
	}
	links {
		"Luau.CLI.Lib",
		
		"Luau.Common",
		
		"Luau.Ast",
		
		"Luau.Config",
		
		"Luau.Analysis",
		"Luau.EqSat",
		"Luau.Compiler",
		"Luau.VM",
		"Luau.Require",
		"Luau.Bytecode",
	}
	
	filter "action:gmake"
	links { "pthread" }

project "luau-compile"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "CLI/include", PREFIX .. "Common/include",
		
		PREFIX .. "Ast/include",
		PREFIX .. "Compiler/include",
		PREFIX .. "CodeGen/include",
		PREFIX .. "VM/include",
		PREFIX .. "Bytecode/include",
	}
	files {
		PREFIX .. "CLI/src/Compile.cpp",
	}
	links {
		"Luau.Common", "Luau.Config",

		"Luau.Ast",
		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.VM",
		"Luau.Bytecode",
	}
	--filter "action:gmake"
	--links { "pthread" }

	
project "luau-bytecode"
	kind "ConsoleApp"
	cppdialect "C++17"
	includedirs {
		PREFIX .. "CLI/include", PREFIX .. "Common/include",
		
		PREFIX .. "Ast/include",
		PREFIX .. "Compiler/include",
		PREFIX .. "CodeGen/include",
		PREFIX .. "VM/include",

		PREFIX .. "Bytecode/include",
	}
	files {
		PREFIX .. "CLI/src/Bytecode.cpp",
	}
	links {
		"Luau.CLI.LIB",

		"Luau.Common",
		"Luau.Ast",
		"Luau.Compiler",
		"Luau.CodeGen",
		"Luau.VM",
		"Luau.Bytecode",
	}
	--filter "action:gmake"
	--links { "pthread" }

project "Luau.Web"
	kind "ConsoleApp"
	includedirs {
		PREFIX .. "Common/include",
		PREFIX .. "Compiler/include",
		PREFIX .. "VM/include",
	}
	files { 
		PREFIX .. "CLI/src/Web.cpp",
	}
	links {
		"Luau.Ast",
		"Luau.Compiler",
		"Luau.VM",
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
