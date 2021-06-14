;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function
PrototypeC ZmqErrnoFunc()
PrototypeC ZmqVersionFunc(*major.Integer, *minor.Integer, *patch.Integer)

; Zmq Function Declare

; <summary>
; ZmqErrno
; </summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqErrno(dllInstance.i)
  Protected.i lResult
  Protected.ZmqErrnoFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_errno")
    
    If pFuncCall > 0
      lResult = pFuncCall()
    EndIf  
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqVersion
; </summary>
; <param name="dllInstance"></param>
; <param name="major"></param>
; <param name="minor"></param>
; <param name="patch"></param>
; <returns>Returns void.</returns>
Procedure ZmqVersion(dllInstance.i, *major.Integer, *minor.Integer, *patch.Integer)
  Protected.ZmqVersionFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_version")
    
    If pFuncCall > 0
      pFuncCall(*major, *minor, *patch)
    EndIf
  EndIf
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 47
; Folding = -
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0