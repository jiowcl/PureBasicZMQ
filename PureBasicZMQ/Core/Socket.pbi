;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function
PrototypeC.i ZmqSocketFunc(s.i, type.i)
PrototypeC.i ZmqBindFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqUnBindFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqRecvFunc(socket.i, *buf.p-Ascii, len.i, flags.i)
PrototypeC.i ZmqSendFunc(socket.i, buf.p-Ascii, leng.i, flags.i)
PrototypeC.i ZmqSendConstFunc(socket.i, buf.p-Ascii, leng.i, flags.i)
PrototypeC.i ZmqConnectFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqDisConnectFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqSetsockoptFunc(socket.i, option.i, optval.p-Ascii, optvallen.i)
PrototypeC.i ZmqGetsockoptFunc(socket.i, option.i, *optval.p-Ascii, optvallen.i)
PrototypeC.i ZmqCloseFunc(socket.i)

; Zmq Function Declare

; <summary>
; ZmqSocket
; </summary>
; <param name="dllInstance"></param>
; <param name="s"></param>
; <param name="type"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqSocket(dllInstance.i, s.i, type.i)
  Protected.i lResult
  Protected.ZmqSocketFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_socket")
    lResult = pFuncCall(s, type)
  EndIf
    
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqBind
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="addr"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqBind(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqBindFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_bind")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqUnBind
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="addr"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqUnBind(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqBindFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_unbind")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqRecv
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="buf"></param>
; <param name="len"></param>
; <param name="flags"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqRecv(dllInstance.i, socket.i, *buf.String, len.i, flags.i)
  Protected.i lResult
  Protected.ZmqRecvFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_recv")
    lResult = pFuncCall(socket, *buf, len, flags)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqSend
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="buf"></param>
; <param name="len"></param>
; <param name="flags"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqSend(dllInstance.i, socket.i, buf.s, len.i, flags.i)
  Protected.i lResult
  Protected.ZmqSendFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_send")
    lResult = pFuncCall(socket, buf, len, flags)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqSendConst
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="buf"></param>
; <param name="len"></param>
; <param name="flags"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqSendConst(dllInstance.i, socket.i, buf.s, len.i, flags.i)
  Protected.i lResult
  Protected.ZmqSendConstFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_send_const")
    lResult = pFuncCall(socket, buf, len, flags)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqConnect
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="addr"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqConnect(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqConnectFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_connect")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqDisConnect
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="addr"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqDisConnect(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqDisConnectFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_disconnect")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqSetsockopt
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="option"></param>
; <param name="optval"></param>
; <param name="optvallen"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqSetsockopt(dllInstance.i, socket.i, option.i, optval.s, optvallen.i)
  Protected.i lResult
  Protected.ZmqSetsockoptFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_setsockopt")
    lResult = pFuncCall(socket, option, optval, optvallen)
  EndIf  
  
  ProcedureReturn lResult
EndProcedure  

; <summary>
; ZmqGetsockopt
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="option"></param>
; <param name="optval"></param>
; <param name="optvallen"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqGetsockopt(dllInstance.i, socket.i, option.i, *optval, optvallen.i)
  Protected.i lResult
  Protected.ZmqGetsockoptFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_getsockopt")
    lResult = pFuncCall(socket, option, *optval, optvallen)
  EndIf  
  
  ProcedureReturn lResult
EndProcedure  

; <summary>
; ZmqClose
; </summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqClose(dllInstance.i, socket.i)
  Protected.i lResult
  Protected.ZmqCloseFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_close")
    lResult = pFuncCall(socket)
  EndIf
  
  ProcedureReturn lResult
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 236
; FirstLine = 186
; Folding = --
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0