#!/usr/bin/env luajit
local ffi = require 'ffi'
local assert = require 'ext.assert'
local mono = require 'mono'

local assemblyPath, className, methodName, namespaceName = ...
assert(
	assemblyPath and className and methodName,
	"expected: run.lua assemblyPath className methodName [namespaceName]"
)
namespaceName = namespaceName or ''

local function monoSafe(name, ...)
	return assert.ne(assert.index(mono, name)(...), ffi.null, name)
end

local domain = monoSafe('mono_jit_init', 'my_domain')
local assembly = monoSafe('mono_domain_assembly_open', domain, assemblyPath)
local image = monoSafe('mono_assembly_get_image', assembly)

local classObj = monoSafe('mono_class_from_name', image, namespaceName, className)
local method = monoSafe('mono_class_get_method_from_name', classObj, methodName, 0)	-- 0 = no args

local result = mono.mono_runtime_invoke(
	method,
	ffi.null,		-- null <-> no instance <-> static method
	ffi.null,		-- null <-> no args
	ffi.null)	-- exception ... none means print to output

mono.mono_jit_cleanup(domain)
