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

; Socket Options
#ZMQ_AFFINITY                          = 4
#ZMQ_ROUTING_ID                        = 5
#ZMQ_SUBSCRIBE                         = 6
#ZMQ_UNSUBSCRIBE                       = 7
#ZMQ_RATE                              = 8
#ZMQ_RECOVERY_IVL                      = 9
#ZMQ_SNDBUF                            = 11
#ZMQ_RCVBUF                            = 12
#ZMQ_RCVMORE                           = 13
#ZMQ_FD                                = 14
#ZMQ_EVENTS                            = 15
#ZMQ_TYPE                              = 16
#ZMQ_LINGER                            = 17
#ZMQ_RECONNECT_IVL                     = 18
#ZMQ_BACKLOG                           = 19
#ZMQ_RECONNECT_IVL_MAX                 = 21
#ZMQ_MAXMSGSIZE                        = 22
#ZMQ_SNDHWM                            = 23
#ZMQ_RCVHWM                            = 24
#ZMQ_MULTICAST_HOPS                    = 25
#ZMQ_RCVTIMEO                          = 27
#ZMQ_SNDTIMEO                          = 28
#ZMQ_LAST_ENDPOINT                     = 32
#ZMQ_ROUTER_MANDATORY                  = 33
#ZMQ_TCP_KEEPALIVE                     = 34
#ZMQ_TCP_KEEPALIVE_CNT                 = 35
#ZMQ_TCP_KEEPALIVE_IDLE                = 36
#ZMQ_TCP_KEEPALIVE_INTVL               = 37
#ZMQ_IMMEDIATE                         = 39
#ZMQ_XPUB_VERBOSE                      = 40
#ZMQ_ROUTER_RAW                        = 41
#ZMQ_IPV6                              = 42
#ZMQ_MECHANISM                         = 43
#ZMQ_PLAIN_SERVER                      = 44
#ZMQ_PLAIN_USERNAME                    = 45
#ZMQ_PLAIN_PASSWORD                    = 46
#ZMQ_CURVE_SERVER                      = 47
#ZMQ_CURVE_PUBLICKEY                   = 48
#ZMQ_CURVE_SECRETKEY                   = 49
#ZMQ_CURVE_SERVERKEY                   = 50
#ZMQ_PROBE_ROUTER                      = 51
#ZMQ_REQ_CORRELATE                     = 52
#ZMQ_REQ_RELAXED                       = 53
#ZMQ_CONFLATE                          = 54
#ZMQ_ZAP_DOMAIN                        = 55
#ZMQ_ROUTER_HANDOVER                   = 56
#ZMQ_TOS                               = 57
#ZMQ_CONNECT_ROUTING_ID                = 61
#ZMQ_GSSAPI_SERVER                     = 62
#ZMQ_GSSAPI_PRINCIPAL                  = 63
#ZMQ_GSSAPI_SERVICE_PRINCIPAL          = 64
#ZMQ_GSSAPI_PLAINTEXT                  = 65
#ZMQ_HANDSHAKE_IVL                     = 66
#ZMQ_SOCKS_PROXY                       = 68
#ZMQ_XPUB_NODROP                       = 69
#ZMQ_BLOCKY                            = 70
#ZMQ_XPUB_MANUAL                       = 71
#ZMQ_XPUB_WELCOME_MSG                  = 72
#ZMQ_STREAM_NOTIFY                     = 73
#ZMQ_INVERT_MATCHING                   = 74
#ZMQ_HEARTBEAT_IVL                     = 75
#ZMQ_HEARTBEAT_TTL                     = 76
#ZMQ_HEARTBEAT_TIMEOUT                 = 77
#ZMQ_XPUB_VERBOSER                     = 78
#ZMQ_CONNECT_TIMEOUT                   = 79
#ZMQ_TCP_MAXRT                         = 80
#ZMQ_THREAD_SAFE                       = 81
#ZMQ_MULTICAST_MAXTPDU                 = 84
#ZMQ_VMCI_BUFFER_SIZE                  = 85
#ZMQ_VMCI_BUFFER_MIN_SIZE              = 86
#ZMQ_VMCI_BUFFER_MAX_SIZE              = 87
#ZMQ_VMCI_CONNECT_TIMEOUT              = 88
#ZMQ_USE_FD                            = 89
#ZMQ_GSSAPI_PRINCIPAL_NAMETYPE         = 90
#ZMQ_GSSAPI_SERVICE_PRINCIPAL_NAMETYPE = 91
#ZMQ_BINDTODEVICE                      = 92

; Message Options
#ZMQ_MORE   = 1
#ZMQ_SHARED = 3

; Send/recv Options
#ZMQ_DONTWAIT = 1
#ZMQ_SNDMORE  = 2

; Prototype Function
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
PrototypeC.i ZmqSetsockoptFunc(socket.i, option.i, optval.p-Ascii, optvallen.i)
PrototypeC.i ZmqGetsockoptFunc(socket.i, option.i, *optval.p-Ascii, optvallen.i)
PrototypeC.i ZmqCloseFunc(socket.i)

; Function Declare
Declare.i ZmqDllOpen(lpszDllPath.s)
Declare.i ZmqDllClose(dllInstance.i)

; <summary>
; ZmqDllOpen
; <summary>
; <param name="lpszDllPath"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqDllOpen(lpszDllPath.s)
  ProcedureReturn OpenLibrary(#PB_Any, lpszDllPath)
EndProcedure

; <summary>
; ZmqDllClose
; <summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqDllClose(dllInstance.i)
  If IsLibrary(dllInstance)
    CloseLibrary(dllInstance)
  EndIf
  
  ProcedureReturn #True
EndProcedure

; Zmq Function Declare

; <summary>
; ZmqCtxNew
; <summary>
; <param name="dllInstance"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxNew(dllInstance.i)
  Protected.i lResult
  Protected.ZmqCtxNewFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_new")
    lResult = pFuncCall()
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqCtxTerm
; <summary>
; <param name="dllInstance"></param>
; <param name="context"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxTerm(dllInstance.i, context.i)
  Protected.i lResult
  Protected.ZmqCtxTermFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_term")
    lResult = pFuncCall(context)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqCtxShutdown
; <summary>
; <param name="dllInstance"></param>
; <param name="context"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqCtxShutdown(dllInstance.i, context.i)
  Protected.i lResult
  Protected.ZmqCtxShutdownFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_ctx_shutdown")
    lResult = pFuncCall(context)
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqSocket
; <summary>
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
; <summary>
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
; <summary>
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
; <summary>
; <param name="dllInstance"></param>
; <param name="socket"></param>
; <param name="buf"></param>
; <param name="len"></param>
; <param name="flags"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqRecv(dllInstance.i, socket.i, *buf, len.i, flags.i)
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
; <summary>
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
; ZmqConnect
; <summary>
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
; <summary>
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
; <summary>
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
; <summary>
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
; <summary>
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
; CursorPosition = 123
; FirstLine = 117
; Folding = ---
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0