;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function
PrototypeC ZmqSleepFunc(seconds_.i)

PrototypeC.i ZmqThreadstartFunc(*func_.ZmqThreadFnProc, arg_.i)
PrototypeC ZmqThreadcloseFunc(thread_.i)

; Zmq Function Declare

; <summary>
; ZmqSleep
; </summary>
; <param name="dllInstance"></param>
; <param name="seconds_"></param>
; <returns>Returns void.</returns>
Procedure ZmqSleep(dllInstance.i, seconds_.i)
  Protected.ZmqSleepFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_sleep")
    pFuncCall(seconds_)
  EndIf
EndProcedure

; <summary>
; ZmqThreadstart
; </summary>
; <param name="dllInstance"></param>
; <param name="*func_"></param>
; <param name="arg_"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqThreadstart(dllInstance.i, *func_.ZmqThreadFnProc, arg_.i)
  Protected.i lResult
  Protected.ZmqThreadstartFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_threadstart")
    lResult = pFuncCall(*func_, arg_)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqThreadclose
; </summary>
; <param name="dllInstance"></param>
; <param name="thread_"></param>
; <returns>Returns void.</returns>
Procedure ZmqThreadclose(dllInstance.i, thread_.i)
  Protected.ZmqThreadcloseFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_threadclose")
    pFuncCall(thread_)
  EndIf
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 24
; Folding = -
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0