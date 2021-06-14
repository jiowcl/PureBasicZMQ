;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function
PrototypeC.i ZmqCtxNewFunc()
PrototypeC.i ZmqCtxTermFunc(context.i)
PrototypeC.i ZmqCtxShutdownFunc(context.i)
PrototypeC.i ZmqCtxSetFunc(context.i, option.i, optval.i)
PrototypeC.i ZmqCtxGetFunc(context.i, option.i)

; Zmq Function Declare

; <summary>
; ZmqCtxNew
; </summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxNew(dllInstance.i)
  Protected.i lResult
  Protected.ZmqCtxNewFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_new")
    
    If pFuncCall > 0
      lResult = pFuncCall()
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqCtxTerm
; </summary>
; <param name="dllInstance"></param>
; <param name="context"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxTerm(dllInstance.i, context.i)
  Protected.i lResult
  Protected.ZmqCtxTermFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_term")
    
    If pFuncCall > 0
      lResult = pFuncCall(context)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqCtxShutdown
; </summary>
; <param name="dllInstance"></param>
; <param name="context"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxShutdown(dllInstance.i, context.i)
  Protected.i lResult
  Protected.ZmqCtxShutdownFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_shutdown")
    
    If pFuncCall > 0
      lResult = pFuncCall(context)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqCtxSet
; </summary>
; <param name="dllInstance"></param>
; <param name="context"></param>
; <param name="option"></param>
; <param name="optval"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxSet(dllInstance.i, context.i, option.i, optval.i)
  Protected.i lResult
  Protected.ZmqCtxSetFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_set")
    
    If pFuncCall > 0
      lResult = pFuncCall(context, option, optval)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqCtxGet
; </summary>
; <param name="dllInstance"></param>
; <param name="context"></param>
; <param name="option"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxGet(dllInstance.i, context.i, option.i)
  Protected.i lResult
  Protected.ZmqCtxGetFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_get")
    
    If pFuncCall > 0
      lResult = pFuncCall(context, option)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 25
; Folding = -
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0