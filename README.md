# C#/Mono in LuaJIT

## Usage:
```
luajit run.lua assemblyPath className methodName [namespaceName]
```

## Example:
1) Compile the C#:
```
mcs Test.cs -target:library
```

2) Invoke it in a real JIT language like LuaJIT:
```
luajit run.lua Test.dll Test test
```
