;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszCurrentDir.s = GetCurrentDirectory()

; Libzmq version (x86/x64)
CompilerIf #PB_Compiler_Processor = #PB_Processor_x64
  Global lpszLibZmqDir.s = "Library/x64"
  Global lpszLibZmqDll.s = lpszCurrentDir + lpszLibZmqDir + "/libzmq.dll"
  
  SetCurrentDirectory(lpszCurrentDir + lpszLibZmqDir)
CompilerElse
  Global lpszLibZmqDir.s = "Library/x86"
  Global lpszLibZmqDll.s = lpszCurrentDir + lpszLibZmqDir + "/libzmq.dll"  
  
  SetCurrentDirectory(lpszCurrentDir + lpszLibZmqDir)
CompilerEndIf

Global lpszServerAddr.s = "tcp://*:1700"
Global lpszServerClientAddr.s = "tcp://localhost:1700"

; ZmqFreeFnProc
Procedure ZmqFreeFnProc(vData.i, vHint.i)
  Debug "vData: " + PeekS(vData, -1, #PB_UTF8)
  Debug "vHint: " + vHint
EndProcedure

; Rep Server
ProcedureC TestZmqThreadRepProc(vData.i)
  Protected.i Socket = vData
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  While 1    
    Define vMsgRecv.ZmqMsgT
    Define vMsgSend.ZmqMsgT
    
    ZmqMsg::Init(vMsgRecv)
    ZmqMsg::Init(vMsgSend)
    ZmqMsg::InitSize(vMsgSend, 32)
    
    PokeS(ZmqMsg::ZData(vMsgSend), "Hi ", -1, #PB_UTF8)
    
    ZmqMsg::Recv(vMsgRecv, Socket, 0)
    
    Delay(10)
    
    PrintN("Received: ")
    PrintN( PeekS(ZmqMsg::ZData(vMsgRecv), -1, #PB_UTF8) )
    
    ZmqMsg::Send(vMsgSend, Socket, 0)
    
    ZmqMsg::Close(vMsgRecv)
    ZmqMsg::Close(vMsgSend)
  Wend
EndProcedure  

; Req Client
ProcedureC TestZmqThreadReqProc(vData.i)
  Protected.i Socket = vData
  Protected.i i
  
  PrintN("Connect to Server: " + lpszServerAddr)
  
  For i = 0 To 20
    Define vMsgRecv.ZmqMsgT
    Define vMsgSend.ZmqMsgT
    
    ZmqMsg::Init(vMsgRecv)
    ZmqMsg::Init(vMsgSend)
    ZmqMsg::InitSize(vMsgSend, 32)
    
    PokeS(ZmqMsg::ZData(vMsgSend), "From Client", -1, #PB_UTF8)
    
    ZmqMsg::Send(vMsgSend, Socket, 0)
    
    Delay(100)
    
    ZmqMsg::Recv(vMsgRecv, Socket, 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(ZmqMsg::ZData(vMsgRecv), -1, #PB_UTF8) )
    
    ZmqMsg::Close(vMsgRecv)
    ZmqMsg::Close(vMsgSend)
  Next
EndProcedure  

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Define ContextRep.i = ZmqContext::New()
  Define SocketRep.i = ZmqSocket::Socket(ContextRep, #ZMQ_REP)
  Define RcRep.i = ZmqSocket::Bind(SocketRep, lpszServerAddr)
  
  Define ContextReq.i = ZmqContext::New()
  Define SocketReq.i = ZmqSocket::Socket(ContextReq, #ZMQ_REQ)
  Define RcReq.i = ZmqSocket::Connect(SocketReq, lpszServerClientAddr)
  
  Define threadRep.i = ZmqHelper::Threadstart(@TestZmqThreadRepProc(), SocketRep)
  Define threadReq.i = ZmqHelper::Threadstart(@TestZmqThreadReqProc(), SocketReq)
  
  Input()
  CloseConsole()
  
  ZmqHelper::Threadclose(threadRep)
  ZmqHelper::Threadclose(threadReq)
  
  ZmqSocket::Close(SocketRep)
  ZmqContext::Shutdown(ContextRep)
  
  ZmqSocket::Close(SocketReq)
  ZmqContext::Shutdown(ContextReq)
  
  DllClose()
EndIf
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 50
; FirstLine = 38
; Folding = -
; EnableXP
; Executable = ..\..\ModuleMsg.exe
; CurrentDirectory = ../../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com