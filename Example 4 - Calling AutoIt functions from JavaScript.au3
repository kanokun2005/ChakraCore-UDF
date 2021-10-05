#include "ChakraCore.au3"

_ChakraCore_Startup()

; Create runtime and context objects
Global $hRuntime = _ChakraCore_CreateRuntime(0)
Global $hContext = _ChakraCore_CreateContext($hRuntime)

; Set the current execution context
_ChakraCore_SetCurrentContext($hContext)

; Get the global object (basically everything belongs to it)
Global $hGlobalObj = _ChakraCore_GetGlobalObject()

; Create a function
Global $hFunc = _ChakraCore_CreateFunction("_GetFileContents")

; Set 'getFileContents' to the function
_ChakraCore_SetProperty($hGlobalObj, _ChakraCore_GetPropertyIdFromName("getFileContents"), $hFunc)

; Execute!
$hOutput = _ChakraCore_RunScript(FileRead("Example 4.js"), 0)

; Get the string from JsValue pointer
$sOutput = _ChakraCore_GetString($hOutput)
ConsoleWrite("JavaScript Output: "&$sOutput&@CRLF)

; Clean up
_ChakraCore_DisposeRuntime($hRuntime)

_ChakraCore_Shutdown()

Func _GetFileContents($hCallee, $bIsConstructCall, $pArguments, $iArgCount, $pCallbackState)
	Local $tArgs = DllStructCreate("ptr args["&$iArgCount&"]", $pArguments)
	Local $hFilePath = $tArgs.args(2) ; First argument is always a reference to the function object
	Local $sFilePath = _ChakraCore_GetString($hFilePath)

	Return _ChakraCore_CreateString(FileRead($sFilePath))
EndFunc