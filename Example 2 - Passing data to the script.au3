#include "ChakraCore.au3"

_ChakraCore_Startup()

; Create runtime and context objects
Global $hRuntime = _ChakraCore_CreateRuntime(0)
Global $hContext = _ChakraCore_CreateContext($hRuntime)

; Set the current execution context
_ChakraCore_SetCurrentContext($hContext)

; Get the global object (basically everything belongs to it)
Global $hGlobalObj = _ChakraCore_GetGlobalObject()

; Set up the variables to pass
Global $iA = 5, $iB = 12

; Set 'a' to $iA
Global $hA = _ChakraCore_CreateNumber($iA)
_ChakraCore_SetProperty($hGlobalObj, _ChakraCore_GetPropertyIdFromName("a"), $hA)

; Set 'b' to $iB
Global $hB = _ChakraCore_CreateNumber($iB)
_ChakraCore_SetProperty($hGlobalObj, _ChakraCore_GetPropertyIdFromName("b"), $hB)

; Execute!
$hOutput = _ChakraCore_RunScript(FileRead("Example 2.js"), 0)

; Get the number from JsValue pointer
$iOutput = _ChakraCore_GetNumber($hOutput)
ConsoleWrite("JavaScript Output: "&$iOutput&@CRLF)

; Clean up
_ChakraCore_DisposeRuntime($hRuntime)

_ChakraCore_Shutdown()