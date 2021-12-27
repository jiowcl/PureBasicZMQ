;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

CompilerIf #PB_Compiler_Version < 520
  CompilerWarning "PureBasic 5.2.0 Version Required."
CompilerEndIf

; Declare Module ZeroMQWrapper
DeclareModule ZeroMQWrapper
  Global dllInstance.i
  
  Declare.i DllOpen(lpszDllPath.s)
  Declare.i DllClose()
EndDeclareModule

; Declare Module ZmqRuntime
DeclareModule ZmqRuntime 
  Declare.i Errno()
  Declare.s Strerror(errnum.i)
  Declare Version(*major.Integer, *minor.Integer, *patch.Integer)
EndDeclareModule

; Declare Module ZmqContext
DeclareModule ZmqContext
  Declare.i New()
  Declare.i Term(context.i)
  Declare.i Shutdown(context.i)
  Declare.i Set(context.i, option.i, optval.i)
  Declare.i Get(context.i, option.i)
EndDeclareModule

; Declare Module ZmqSocket
DeclareModule ZmqSocket
  Declare.i Socket(s.i, type.i)
  Declare.i SocketMonitor(socket.i, addr.s, events.i)
  Declare.i Bind(socket.i, addr.s)
  Declare.i UnBind(socket.i, addr.s)
  Declare.i Recv(socket.i, *buf, len.i, flags.i)
  Declare.i Send(socket.i, buf.s, leng.i, flags.i)
  Declare.i Connect(socket.i, addr.s)
  Declare.i DisConnect(socket.i, addr.s)
  Declare.i Setsockopt(socket.i, option.i, optval.s, optvallen.i)
  Declare.i Getsockopt(socket.i, option.i, *optval, optvallen.i)
  Declare.i Close(socket.i)
EndDeclareModule  

; Declare Module ZmqMsg
DeclareModule ZmqMsg
  IncludeFile "Enums.pbi"
    
  Declare.i Init(*msg.ZmqMsgT)
  Declare.i InitSize(*msg.ZmqMsgT, size.i)
  Declare.i InitData(*msg.ZmqMsgT, vData.i, size.i, *ffn.ZmqFreeFnProc, hint.i)
  Declare.i Send(*msg.ZmqMsgT, socket.i, flags.i)
  Declare.i Recv(*msg.ZmqMsgT, socket.i, flags.i)
  Declare.i Close(*msg.ZmqMsgT)
  Declare.i Move(*destmsg.ZmqMsgT, *srcmsg.ZmqMsgT)
  Declare.i Copy(*destmsg.ZmqMsgT, *srcmsg.ZmqMsgT)
  Declare.i ZData(*msg.ZmqMsgT)
  Declare.i Size(*msg.ZmqMsgT)
  Declare.i More(*msg.ZmqMsgT)
  Declare.i Get(*msg.ZmqMsgT, property.i)
  Declare.i Set(*msg.ZmqMsgT, property.i, optval.i)
  Declare.s Gets(*msg.ZmqMsgT, property.s)
EndDeclareModule   

; Declare Module ZmqHelper
DeclareModule ZmqHelper
  IncludeFile "Enums.pbi"
  
  Declare.i StopwatchStart()
  Declare.l StopwatchIntermediate(watch_.i)
  Declare.l StopwatchStop(watch_.i)
    
  Declare Sleep(seconds_.i)
  Declare.i Threadstart(*func_.ZmqThreadFnProc, arg_.i)
  Declare Threadclose(thread_.i)
EndDeclareModule  

; Module ZeroMQWrapper
Module ZeroMQWrapper
  IncludeFile "LibDll.pbi"
  
  ; <summary>
  ; DllOpen
  ; </summary>
  ; <param name="lpszDllPath"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i DllOpen(lpszDllPath.s)
    If IsLibrary(dllInstance)
      ProcedureReturn dllInstance
    EndIf
    
    dllInstance = ZmqDllOpen(lpszDllPath)
    
    ProcedureReturn dllInstance
  EndProcedure
  
  ; <summary>
  ; DllClose
  ; </summary>
  ; <param name="dllInstance"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i DllClose()
    ProcedureReturn ZmqDllClose(dllInstance)
  EndProcedure
EndModule

; Module ZmqRuntime
Module ZmqRuntime
  IncludeFile "Runtime.pbi"
  
  ; <summary>
  ; Errno
  ; </summary>
  ; <returns>Returns integer.</returns>
  Procedure.i Errno()
    ProcedureReturn ZmqErrno(ZeroMQWrapper::dllInstance)
  EndProcedure
  
  ; <summary>
  ; Strerror
  ; </summary>
  ; <param name="errnum"></param>
  ; <returns>Returns string.</returns>
  Procedure.s Strerror(errnum.i)
    ProcedureReturn ZmqStrerror(ZeroMQWrapper::dllInstance, errnum)
  EndProcedure
  
  ; <summary>
  ; Version
  ; </summary>
  ; <param name="major"></param>
  ; <param name="minor"></param>
  ; <param name="patch"></param>
  ; <returns>Returns void.</returns>
  Procedure Version(*major.Integer, *minor.Integer, *patch.Integer)
    ZmqVersion(ZeroMQWrapper::dllInstance, *major, *minor, *patch)
  EndProcedure
EndModule  

; Module ZmqContext
Module ZmqContext
  IncludeFile "Context.pbi"
  
  UseModule ZeroMQWrapper
  
  ; <summary>
  ; New
  ; </summary>
  ; <returns>Returns integer.</returns>
  Procedure.i New()
    ProcedureReturn ZmqCtxNew(ZeroMQWrapper::dllInstance)
  EndProcedure
  
  ; <summary>
  ; Term
  ; </summary>
  ; <param name="context"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Term(context.i)
    ProcedureReturn ZmqCtxTerm(ZeroMQWrapper::dllInstance, context)
  EndProcedure
  
  ; <summary>
  ; Shutdown
  ; </summary>
  ; <param name="context"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Shutdown(context.i)
    ProcedureReturn ZmqCtxShutdown(ZeroMQWrapper::dllInstance, context)
  EndProcedure
  
  ; <summary>
  ; Set
  ; </summary>
  ; <param name="context"></param>
  ; <param name="option"></param>
  ; <param name="optval"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Set(context.i, option.i, optval.i)
    ProcedureReturn ZmqCtxSet(ZeroMQWrapper::dllInstance, context, option, optval)
  EndProcedure
  
  ; <summary>
  ; Get
  ; </summary>
  ; <param name="context"></param>
  ; <param name="option"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Get(context.i, option.i)
    ProcedureReturn ZmqCtxGet(ZeroMQWrapper::dllInstance, context, option)
  EndProcedure
EndModule

; Module ZmqSocket
Module ZmqSocket
  IncludeFile "Socket.pbi"
  
  UseModule ZeroMQWrapper
  
  ; <summary>
  ; Socket
  ; </summary>
  ; <param name="s"></param>
  ; <param name="type"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Socket(s.i, type.i)
    ProcedureReturn ZmqSocket(ZeroMQWrapper::dllInstance, s, type)
  EndProcedure
  
  ; <summary>
  ; SocketMonitor
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="addr"></param>
  ; <param name="events"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i SocketMonitor(socket.i, addr.s, events.i)
    ProcedureReturn ZmqSocketMonitor(ZeroMQWrapper::dllInstance, socket, addr, events)
  EndProcedure
  
  ; <summary>
  ; Bind
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="addr"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Bind(socket.i, addr.s)
    ProcedureReturn ZmqBind(ZeroMQWrapper::dllInstance, socket, addr)
  EndProcedure
  
  ; <summary>
  ; UnBind
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="addr"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i UnBind(socket.i, addr.s)
    ProcedureReturn ZmqUnBind(ZeroMQWrapper::dllInstance, socket, addr)
  EndProcedure
  
  ; <summary>
  ; Recv
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="*buf"></param>
  ; <param name="len"></param>
  ; <param name="flags"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Recv(socket.i, *buf, len.i, flags.i)
    ProcedureReturn ZmqRecv(ZeroMQWrapper::dllInstance, socket, *buf, len, flags)
  EndProcedure
  
  ; <summary>
  ; Send
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="buf"></param>
  ; <param name="len"></param>
  ; <param name="flags"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Send(socket.i, buf.s, len.i, flags.i)
    ProcedureReturn ZmqSend(ZeroMQWrapper::dllInstance, socket, buf, len, flags)
  EndProcedure
  
  ; <summary>
  ; SendConst
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="buf"></param>
  ; <param name="len"></param>
  ; <param name="flags"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i SendConst(socket.i, buf.s, len.i, flags.i)
    ProcedureReturn ZmqSendConst(ZeroMQWrapper::dllInstance, socket, buf, len, flags)
  EndProcedure
  
  ; <summary>
  ; Connect
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="addr"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Connect(socket.i, addr.s)
    ProcedureReturn ZmqConnect(ZeroMQWrapper::dllInstance, socket, addr)
  EndProcedure
  
  ; <summary>
  ; DisConnect
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="addr"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i DisConnect(socket.i, addr.s)
    ProcedureReturn ZmqDisConnect(ZeroMQWrapper::dllInstance, socket, addr)
  EndProcedure
  
  ; <summary>
  ; Setsockopt
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="option"></param>
  ; <param name="optval"></param>
  ; <param name="optvallen"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Setsockopt(socket.i, option.i, optval.s, optvallen.i)
    ProcedureReturn ZmqSetsockopt(ZeroMQWrapper::dllInstance, socket, option, optval, optvallen)
  EndProcedure  
  
  ; <summary>
  ; Getsockopt
  ; </summary>
  ; <param name="socket"></param>
  ; <param name="option"></param>
  ; <param name="*optval"></param>
  ; <param name="optvallen"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Getsockopt(socket.i, option.i, *optval, optvallen.i)
    ProcedureReturn ZmqGetsockopt(ZeroMQWrapper::dllInstance, socket, option, *optval, optvallen)
  EndProcedure
  
  ; <summary>
  ; Close
  ; </summary>
  ; <param name="socket"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Close(socket.i)
    ProcedureReturn ZmqClose(ZeroMQWrapper::dllInstance, socket)
  EndProcedure  
EndModule

; Module ZmqMsg
Module ZmqMsg
  ;IncludeFile "Enums.pbi"
  IncludeFile "Msg.pbi"
  
  UseModule ZeroMQWrapper
  
  ; <summary>
  ; Init
  ; </summary>
  ; <param name="*msg"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Init(*msg.ZmqMsgT)
    ProcedureReturn ZmqMsgInit(ZeroMQWrapper::dllInstance, *msg)
  EndProcedure

  ; <summary>
  ; InitSize
  ; </summary>
  ; <param name="*msg"></param>
  ; <param name="size"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i InitSize(*msg.ZmqMsgT, size.i) 
    ProcedureReturn ZmqMsgInitSize(ZeroMQWrapper::dllInstance, *msg, size)
  EndProcedure

  ; <summary>
  ; InitData
  ; </summary>
  ; <param name="*msg"></param>
  ; <param name="vdata"></param>
  ; <param name="size"></param>
  ; <param name="*ffn"></param>
  ; <param name="hint"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i InitData(*msg.ZmqMsgT, vdata.i, size.i, *ffn.ZmqFreeFnProc, hint.i) 
    ProcedureReturn ZmqMsgInitData(ZeroMQWrapper::dllInstance, *msg, vdata, size, *ffn, hint)
  EndProcedure

  ; <summary>
  ; Send
  ; </summary>
  ; <param name="*msg"></param>
  ; <param name="socket"></param>
  ; <param name="flags"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Send(*msg.ZmqMsgT, socket.i, flags.i) 
    ProcedureReturn ZmqMsgSend(ZeroMQWrapper::dllInstance, *msg.ZmqMsgT, socket, flags)
  EndProcedure

  ; <summary>
  ; Recv
  ; </summary>
  ; <param name="*msg"></param>
  ; <param name="socket"></param>
  ; <param name="flags"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Recv(*msg.ZmqMsgT, socket.i, flags.i) 
    ProcedureReturn ZmqMsgRecv(ZeroMQWrapper::dllInstance, *msg.ZmqMsgT, socket, flags)
  EndProcedure

  ; <summary>
  ; Close
  ; </summary>
  ; <param name="*msg"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Close(*msg.ZmqMsgT) 
    ProcedureReturn ZmqMsgClose(ZeroMQWrapper::dllInstance, *msg.ZmqMsgT)
  EndProcedure

  ; <summary>
  ; Move
  ; </summary>
  ; <param name="*destmsg"></param>
  ; <param name="*srcmsg"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Move(*destmsg.ZmqMsgT, *srcmsg.ZmqMsgT) 
    ProcedureReturn ZmqMsgMove(ZeroMQWrapper::dllInstance, *destmsg, *srcmsg)
  EndProcedure

  ; <summary>
  ; Copy
  ; </summary>
  ; <param name="*destmsg"></param>
  ; <param name="*srcmsg"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Copy(*destmsg.ZmqMsgT, *srcmsg.ZmqMsgT) 
    ProcedureReturn ZmqMsgCopy(ZeroMQWrapper::dllInstance, *destmsg, *srcmsg)
  EndProcedure

  ; <summary>
  ; ZData
  ; </summary>
  ; <param name="*msg"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i ZData(*msg.ZmqMsgT) 
    ProcedureReturn ZmqMsgData(ZeroMQWrapper::dllInstance, *msg)
  EndProcedure

  ; <summary>
  ; Size
  ; </summary>
  ; <param name="*msg"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Size(*msg.ZmqMsgT) 
    ProcedureReturn ZmqMsgSize(ZeroMQWrapper::dllInstance, *msg)
  EndProcedure

  ; <summary>
  ; More
  ; </summary>
  ; <param name="*msg"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i More(*msg.ZmqMsgT) 
    ProcedureReturn ZmqMsgMore(ZeroMQWrapper::dllInstance, *msg)
  EndProcedure

  ; <summary>
  ; Get
  ; </summary>
  ; <param name="*msg"></param>
  ; <param name="property"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Get(*msg.ZmqMsgT, property.i) 
    ProcedureReturn ZmqMsgGet(ZeroMQWrapper::dllInstance, *msg, property)
  EndProcedure
  
  ; <summary>
  ; Set
  ; </summary>
  ; <param name="*msg"></param>
  ; <param name="property"></param>
  ; <param name="optval"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Set(*msg.ZmqMsgT, property.i, optval.i)
    ProcedureReturn ZmqMsgSet(ZeroMQWrapper::dllInstance, *msg, property, optval)
  EndProcedure
  
  ; <summary>
  ; Gets
  ; </summary>
  ; <param name="*msg"></param>
  ; <param name="property"></param>
  ; <returns>Returns string.</returns>
  Procedure.s Gets(*msg.ZmqMsgT, property.s) 
    ProcedureReturn ZmqMsgGets(ZeroMQWrapper::dllInstance, *msg, property)
  EndProcedure
EndModule  

; Module ZmqHelper
Module ZmqHelper
  IncludeFile "Helper.pbi"
  
  UseModule ZeroMQWrapper
  
  ; <summary>
  ; StopwatchStart
  ; </summary>
  ; <returns>Returns integer.</returns>
  Procedure.i StopwatchStart()
    ProcedureReturn ZmqStopwatchStart(ZeroMQWrapper::dllInstance)
  EndProcedure
  
  ; <summary>
  ; StopwatchIntermediate
  ; </summary>
  ; <param name="watch_"></param>
  ; <returns>Returns long.</returns>
  Procedure.l StopwatchIntermediate(watch_.i)
    ProcedureReturn ZmqStopwatchIntermediate(ZeroMQWrapper::dllInstance, watch_)
  EndProcedure
  
  ; <summary>
  ; StopwatchStop
  ; </summary>
  ; <param name="watch_"></param>
  ; <returns>Returns long.</returns>
  Procedure.l StopwatchStop(watch_.i)
    ProcedureReturn ZmqStopwatchStop(ZeroMQWrapper::dllInstance, watch_)
  EndProcedure
  
  ; <summary>
  ; Sleep
  ; </summary>
  ; <param name="seconds_"></param>
  ; <returns>Returns void.</returns>
  Procedure Sleep(seconds_.i)
    ZmqSleep(ZeroMQWrapper::dllInstance, seconds_)
  EndProcedure
  
  ; <summary>
  ; Threadstart
  ; </summary>
  ; <param name="*func_"></param>
  ; <param name="arg_"></param>
  ; <returns>Returns integer.</returns>
  Procedure.i Threadstart(*func_.ZmqThreadFnProc, arg_.i)
    ProcedureReturn ZmqThreadstart(ZeroMQWrapper::dllInstance, *func_, arg_)
  EndProcedure 
  
  ; <summary>
  ; Threadclose
  ; </summary>
  ; <param name="thread_"></param>
  ; <returns>Returns void.</returns>
  Procedure Threadclose(thread_.i)
    ZmqThreadclose(ZeroMQWrapper::dllInstance, thread_)
  EndProcedure
EndModule  
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 20
; FirstLine = 12
; Folding = ----------
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0