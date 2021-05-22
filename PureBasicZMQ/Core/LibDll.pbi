;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Function Declare
Declare.i ZmqDllOpen(lpszDllPath.s)
Declare.i ZmqDllClose(dllInstance.i)

; <summary>
; ZmqDllOpen
; </summary>
; <param name="lpszDllPath"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqDllOpen(lpszDllPath.s)
  ProcedureReturn OpenLibrary(#PB_Any, lpszDllPath)
EndProcedure

; <summary>
; ZmqDllClose
; </summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqDllClose(dllInstance.i)
  If IsLibrary(dllInstance)
    CloseLibrary(dllInstance)
  EndIf
  
  ProcedureReturn #True
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 11
; Folding = -
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0