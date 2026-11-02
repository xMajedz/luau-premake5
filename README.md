# Usage
generate build files.
```
premake5 gmake --luau-path=luau
```
build.
```
make -C luau/build config=release luau luau-analyze
```
# Build Luau.Web
make sure you have emscripten.

generate build files.
```
premake5 gmake --os=emscripten --luau-path=luau
```
build
```
make -C luau/build config=release Luau.Web
```
