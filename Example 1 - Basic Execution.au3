#include "ChakraCore.au3"

Local $code = 'function generateCard(bin){'&@CRLF
   $code &= 'var bin2 = "";'&@CRLF
   $code &= 'var bin2_l = [];'&@CRLF
    $code &= 'var card = "";'&@CRLF
    $code &= 'var card1_l = [];'&@CRLF
    $code &= 'var card2_l = [];'&@CRLF
    $code &= 'var sum = 0;'&@CRLF
    $code &= 'var mod = 0;'&@CRLF
    $code &= 'var check_sum = 0;'&@CRLF
    $code &= 'for (var i in bin){'&@CRLF
        $code &= 'char = bin[i].toLowerCase();'&@CRLF
        $code &= 'if (char == "x"){'&@CRLF
            $code &= 'var rand_num = Math.floor(Math.random() * 10);'&@CRLF
            $code &= 'char = rand_num;'&@CRLF
        $code &= '}'&@CRLF
        $code &= 'bin2 += char;'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'for (var i in bin2){'&@CRLF
        $code &= 'bin2_l.push(parseInt(bin2[i]))'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'for (var i in bin2_l){'&@CRLF
        $code &= 'card1_l.push(bin2_l[i]);'&@CRLF
        $code &= 'card2_l.push(bin2_l[i]);'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'for (var i = 0; i < 15 - bin.length; i++){'&@CRLF
        $code &= 'var rand_num = Math.floor(Math.random() * 10);'&@CRLF
        $code &= 'card1_l.push(rand_num);'&@CRLF
        $code &= 'card2_l.push(rand_num);'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'for (var i = 0; i < card2_l.length; i += 2){'&@CRLF
        $code &= 'card2_l[i] *= 2;'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'for (var i in card2_l){'&@CRLF
        $code &= 'if (card2_l[i] > 9){'&@CRLF
            $code &= 'card2_l[i] -= 9;'&@CRLF
        $code &= '}'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'for (var i in card2_l){'&@CRLF
        $code &= 'sum += card2_l[i];'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'mod = sum % 10;'&@CRLF
    $code &= 'if (!mod == 0){'&@CRLF
        $code &= 'check_sum = 10 - mod;'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'card1_l.push(check_sum);'&@CRLF
    $code &= 'for (var i in card1_l){'&@CRLF
        $code &= 'card += card1_l[i];'&@CRLF
    $code &= '}'&@CRLF
    $code &= 'return card;'&@CRLF
$code &= '}'&@CRLF

$code &= '(function() {'&@CRLF
    $code &= 'var bin = "548876xxxxxxxxx"'&@CRLF
    $code &= 'var generatedCard = generateCard(bin);'&@CRLF
        $code &= 'return generatedCard;'&@CRLF
    $code &= '})();'&@CRLF





_ChakraCore_Startup()

; Create runtime and context objects
Global $hRuntime = _ChakraCore_CreateRuntime(0)
Global $hContext = _ChakraCore_CreateContext($hRuntime)

; Set the current execution context
_ChakraCore_SetCurrentContext($hContext)

; Execute!
;$hOutput = _ChakraCore_RunScript(FileRead("Example 1.js"), 0)
$hOutput = _ChakraCore_RunScript($code, 0)





; Get the number from JsValue pointer
$iOutput = _ChakraCore_GetString($hOutput)
MsgBox(0,0,$iOutput)

; Clean up
_ChakraCore_DisposeRuntime($hRuntime)

_ChakraCore_Shutdown()