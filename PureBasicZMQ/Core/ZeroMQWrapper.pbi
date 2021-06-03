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

; Declare Module ZmqHelper
DeclareModule ZmqHelper
  IncludeFile "Enums.pbi"
  
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
    
    dllInstance = ZmqDllOpen(lpszDllPath.s)
    
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
  ; <param name="buf"></param>
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
  ; <param name="optval"></param>
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
    ProcedureReturn ZmqClose(ZeroMQWrapper::dllInstance, socket.i)
  EndProcedure  
EndModule

; Module ZmqHelper
Module ZmqHelper
  IncludeFile "Helper.pbi"
  
  UseModule ZeroMQWrapper
  
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
  Procedure.i Threadclose(thread_.i)
    ProcedureReturn ZmqThreadclose(ZeroMQWrapper::dllInstance, thread_)
  EndProcedure
EndModule  
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 269
; FirstLine = 231
; Folding = -----
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0