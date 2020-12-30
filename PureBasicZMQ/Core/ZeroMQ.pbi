;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Socket Types
#ZMQ_PAIR   = 0
#ZMQ_PUB    = 1
#ZMQ_SUB    = 2
#ZMQ_REQ    = 3
#ZMQ_REP    = 4
#ZMQ_DEALER = 5
#ZMQ_ROUTER = 6
#ZMQ_PULL   = 7
#ZMQ_PUSH   = 8
#ZMQ_XPUB   = 9
#ZMQ_XSUB   = 10
#ZMQ_STREAM = 11

PrototypeC.i ZmqCtxNewFunc()
PrototypeC.i ZmqCtxTermFunc(context.i)
PrototypeC.i ZmqCtxShutdownFunc(context.i)

PrototypeC.i ZmqSocketFunc(s.i, type.i)
PrototypeC.i ZmqBindFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqUnBindFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqRecvFunc(socket.i, *buf.p-Ascii, len.i, flags.i)
PrototypeC.i ZmqSendFunc(socket.i, buf.p-Ascii, leng.i, flags.i)
PrototypeC.i ZmqConnectFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqDisConnectFunc(socket.i, addr.p-Ascii)
PrototypeC.i ZmqCloseFunc(socket.i)

; Function Declare
Declare.i ZmqDllOpen(lpszDllPath.s)
Declare.i ZmqDllClose(hModule.i)

Procedure.i ZmqDllOpen(lpszDllPath.s)
  ProcedureReturn OpenLibrary(#PB_Any, lpszDllPath)
EndProcedure

Procedure.i ZmqDllClose(dllInstance.i)
  If IsLibrary(dllInstance)
    CloseLibrary(dllInstance)
  EndIf
  
  ProcedureReturn #True
EndProcedure

; Zmq Function Declare
Procedure.i ZmqCtxNew(dllInstance.i)
  Protected.i lResult
  Protected.ZmqCtxNewFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_new")
    lResult = pFuncCall()
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqCtxTerm(dllInstance.i, context.i)
  Protected.i lResult
  Protected.ZmqCtxTermFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_term")
    lResult = pFuncCall(context)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqCtxShutdown(dllInstance.i, context.i)
  Protected.i lResult
  Protected.ZmqCtxShutdownFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_shutdown")
    lResult = pFuncCall(context)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqSocket(dllInstance.i, s.i, type.i)
  Protected.i lResult
  Protected.ZmqSocketFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_socket")
    lResult = pFuncCall(s, type)
  EndIf
    
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqBind(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqBindFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_bind")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqUnBind(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqBindFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_unbind")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqRecv(dllInstance.i, socket.i, *buf, len.i, flags.i)
  Protected.i lResult
  Protected.ZmqRecvFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_recv")
    lResult = pFuncCall(socket, *buf, len, flags)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqSend(dllInstance.i, socket.i, buf.s, len.i, flags.i)
  Protected.i lResult
  Protected.ZmqSendFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_send")
    lResult = pFuncCall(socket, buf, len, flags)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqConnect(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqConnectFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_connect")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

Procedure.i ZmqDisConnect(dllInstance.i, socket.i, addr.s)
  Protected.i lResult
  Protected.ZmqDisConnectFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_disconnect")
    lResult = pFuncCall(socket, addr)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

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
; CursorPosition = 3
; Folding = ---
; EnableXP