;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function
PrototypeC.i ZmqStopwatchStartFunc()
PrototypeC.l ZmqStopwatchIntermediateFunc(watch.i)
PrototypeC.l ZmqStopwatchStopFunc(watch.i);
PrototypeC ZmqSleepFunc(seconds_.i)
PrototypeC.i ZmqThreadstartFunc(*func.ZmqThreadFnProc, arg.i)
PrototypeC ZmqThreadcloseFunc(thread.i)

; Zmq Function Declare

; <summary>
; ZmqStopwatchStart
; </summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqStopwatchStart(dllInstance.i)
  Protected.i lResult
  Protected.ZmqStopwatchStartFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_stopwatch_start")
    
    If pFuncCall > 0
      lResult = pFuncCall()
    EndIf  
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqStopwatchIntermediate
; </summary>
; <param name="dllInstance"></param>
; <param name="watch"></param>
; <returns>Returns long.</returns>
Procedure.l ZmqStopwatchIntermediate(dllInstance.i, watch.i)
  Protected.l lResult
  Protected.ZmqStopwatchIntermediateFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_stopwatch_intermediate")
    
    If pFuncCall > 0
      lResult = pFuncCall(watch)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqStopwatchStop
; </summary>
; <param name="dllInstance"></param>
; <param name="watch"></param>
; <returns>Returns long.</returns>
Procedure.l ZmqStopwatchStop(dllInstance.i, watch.i)
  Protected.l lResult
  Protected.ZmqStopwatchStopFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_stopwatch_stop")
    
    If pFuncCall > 0
      lResult = pFuncCall(watch)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqSleep
; </summary>
; <param name="dllInstance"></param>
; <param name="seconds"></param>
; <returns>Returns void.</returns>
Procedure ZmqSleep(dllInstance.i, seconds.i)
  Protected.ZmqSleepFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_sleep")
    
    If pFuncCall > 0
      pFuncCall(seconds)
    EndIf  
  EndIf
EndProcedure

; <summary>
; ZmqThreadstart
; </summary>
; <param name="dllInstance"></param>
; <param name="*func"></param>
; <param name="arg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqThreadstart(dllInstance.i, *func.ZmqThreadFnProc, arg.i)
  Protected.i lResult
  Protected.ZmqThreadstartFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_threadstart")
    
    If pFuncCall > 0
      lResult = pFuncCall(*func, arg)
    EndIf  
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqThreadclose
; </summary>
; <param name="dllInstance"></param>
; <param name="thread"></param>
; <returns>Returns void.</returns>
Procedure ZmqThreadclose(dllInstance.i, thread.i)
  Protected.ZmqThreadcloseFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_threadclose")
    
    If pFuncCall > 0
      pFuncCall(thread)
    EndIf  
  EndIf
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 17
; Folding = --
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0