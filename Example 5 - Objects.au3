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
Global $hFunc = _ChakraCore_CreateFunction("_Add20ToA")

; Set 'add20ToA' to the function
_ChakraCore_SetProperty($hGlobalObj, _ChakraCore_GetPropertyIdFromName("add20ToA"), $hFunc)

; Execute!
$hOutput = _ChakraCore_RunScript(FileRead("Example 5.js"), 0)

; Get the values
$iA = _ChakraCore_GetNumber(_ChakraCore_GetProperty($hOutput, _ChakraCore_GetPropertyIdFromName("a")))
$sB = _ChakraCore_GetString(_ChakraCore_GetProperty($hOutput, _ChakraCore_GetPropertyIdFromName("b")))
ConsoleWrite("a: "&$iA&@CRLF)
ConsoleWrite("b: "&$sB&@CRLF)

; Clean up
_ChakraCore_DisposeRuntime($hRuntime)

_ChakraCore_Shutdown()

Func _Add20ToA($hCallee, $bIsConstructCall, $pArguments, $iArgCount, $pCallbackState)
	Local $tArgs = DllStructCreate("ptr args["&$iArgCount&"]", $pArguments)
	Local $hObject = $tArgs.args(2) ; First argument is always a reference to the function object
	Local $hNumber = _ChakraCore_GetProperty($hObject, _ChakraCore_GetPropertyIdFromName("a"))
	Local $hString = _ChakraCore_GetProperty($hObject, _ChakraCore_GetPropertyIdFromName("b"))

	$hNumber = _ChakraCore_CreateNumber(_ChakraCore_GetNumber($hNumber) + 20)
	_ChakraCore_SetProperty($hObject, _ChakraCore_GetPropertyIdFromName("a"), $hNumber)

	$hString = _ChakraCore_CreateString(StringReverse(_ChakraCore_GetString($hString)))
	_ChakraCore_SetProperty($hObject, _ChakraCore_GetPropertyIdFromName("b"), $hString)

	Return 0
EndFunc