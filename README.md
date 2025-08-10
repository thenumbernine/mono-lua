# C#/Mono in LuaJIT

# Setup:
Linux:
```
apt install mono-devel
```

# Usage:
```
luajit run.lua assemblyPath className methodName [namespaceName]
```

# Example:
1) Compile the C#:
```
mcs Test.cs -target:library
```

2) Invoke it in a real JIT language like LuaJIT:
```
luajit run.lua Test.dll Test test
```

# TODO
- Lua <-> C# interface
