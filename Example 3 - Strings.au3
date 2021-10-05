#include "ChakraCore.au3"

_ChakraCore_Startup()

; Create runtime and context objects
Global $hRuntime = _ChakraCore_CreateRuntime(0)
Global $hContext = _ChakraCore_CreateContext($hRuntime)

; Set the current execution context
_ChakraCore_SetCurrentContext($hContext)

; Get the global object (basically everything belongs to it)
Global $hGlobalObj = _ChakraCore_GetGlobalObject()

; Set 'helloWorldString' to "Hello World!"
Global $hStr = _ChakraCore_CreateString("Hello World!")
_ChakraCore_SetProperty($hGlobalObj, _ChakraCore_GetPropertyIdFromName("helloWorldString"), $hStr)

; Execute!
$hOutput = _ChakraCore_RunScript(FileRead("Example 3.js"), 0)

; Get the string from JsValue pointer
$iOutput = _ChakraCore_GetString($hOutput)
ConsoleWrite("JavaScript Output: "&$iOutput&@CRLF)

; Clean up
_ChakraCore_DisposeRuntime($hRuntime)

_ChakraCore_Shutdown()