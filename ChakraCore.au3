#include-once

; #INDEX# =======================================================================================================================
; Title .........: ChakraCore UDF
; UDF Version ...: 1.0.0
; AutoIt Version : 3.3.14.0
; Language ......: English
; Description ...: Using ChakraCore JavaScript engine in AutoIt scripts.
; Author(s) .....: scintilla4evr
; ===============================================================================================================================

Global $__g_ChakraCore_Dll = 0

Func _ChakraCore_Startup($sDllFile = "ChakraCore.dll")
	$__g_ChakraCore_Dll = DllOpen($sDllFile)
	Return 1
EndFunc

Func _ChakraCore_Shutdown()
	DllClose($__g_ChakraCore_Dll)
	Return 1
EndFunc

Func _ChakraCore_CreateRuntime($iRuntimeAttribute)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsCreateRuntime", "dword", $iRuntimeAttribute, "ptr", 0, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[3]
EndFunc

Func _ChakraCore_DisposeRuntime($hRuntime)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsDisposeRuntime", "ptr", $hRuntime)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[0]
EndFunc

Func _ChakraCore_CreateContext($hRuntime)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsCreateContext", "ptr", $hRuntime, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[2]
EndFunc

Func _ChakraCore_SetCurrentContext($hContext)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsSetCurrentContext", "ptr", $hContext)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[0]
EndFunc

Func _ChakraCore_RunScript($sScript, $iCurrentSourceContext)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsRunScript", "wstr", $sScript, "int", $iCurrentSourceContext, "wstr", "", "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[4]
EndFunc

Func _ChakraCore_GetString($hResult)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsConvertValueToString", "ptr", $hResult, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])

	Local $tResult = $aCall[2]

	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsStringToPointer", "ptr", $tResult, "ptr*", 0, "int*", 0)
	If @error Then Return SetError(3, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(4, 0, $aCall[0])

	Local $tString = DllStructCreate("wchar string["&$aCall[3]&"]", $aCall[2])
	Return $tString.string
EndFunc

Func _ChakraCore_GetNumber($hResult)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsConvertValueToNumber", "ptr", $hResult, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])

	Local $tResult = $aCall[2]

	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsNumberToDouble", "ptr", $tResult, "double*", 0)
	If @error Then Return SetError(3, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(4, 0, $aCall[0])
	Return $aCall[2]
EndFunc

Func _ChakraCore_CreateString($sString)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsPointerToString", "wstr", $sString, "int", StringLen($sString), "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[3]
EndFunc

Func _ChakraCore_CreateNumber($fNumber)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsDoubleToNumber", "double", $fNumber, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[2]
EndFunc

Func _ChakraCore_CreateObject()
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsCreateObject", "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[1]
EndFunc

Func _ChakraCore_CreateFunction($sAu3FuncName, $pCallbackState = 0)
	Local $hCallback = DllCallbackRegister($sAu3FuncName, "ptr", "ptr;bool;ptr;ushort;ptr")

	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsCreateFunction", "ptr", DllCallbackGetPtr($hCallback), "ptr", $pCallbackState, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[3]
EndFunc

Func _ChakraCore_GetGlobalObject()
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsGetGlobalObject", "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[1]
EndFunc

Func _ChakraCore_GetPropertyIdFromName($sName)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsGetPropertyIdFromName", "wstr", $sName, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[2]
EndFunc

Func _ChakraCore_SetProperty($hObject, $hPropId, $hValue, $bUseStrictRules = True)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsSetProperty", "ptr", $hObject, "ptr", $hPropId, "ptr", $hValue, "bool", $bUseStrictRules)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[0]
EndFunc

Func _ChakraCore_GetProperty($hObject, $hPropId)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsGetProperty", "ptr", $hObject, "ptr", $hPropId, "ptr*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[3]
EndFunc

Func _ChakraCore_HasProperty($hObject, $hPropId)
	Local $aCall = DllCall($__g_ChakraCore_Dll, "dword", "JsHasProperty", "ptr", $hObject, "ptr", $hPropId, "bool*", 0)
	If @error Then Return SetError(1, 0, @error)
	If $aCall[0] <> 0 Then Return SetError(2, 0, $aCall[0])
	Return $aCall[3]
EndFunc

