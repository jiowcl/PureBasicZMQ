;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://*:1700"
Global lpszServerClientAddr.s = "tcp://localhost:1700"

; Rep Server
ProcedureC TestZmqThreadRepProc(vData.i)
  Protected.i Socket = vData
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  While 1    
    Define *lpszBuffer = AllocateMemory(32)
    Define lpszMessage.s = "Hi "
    
    ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    Delay(10)
    
    PrintN("Received: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    ZmqSocket::Send(Socket, lpszMessage, Len(lpszMessage), 0)
    
    FreeMemory(*lpszBuffer)
  Wend
EndProcedure  

; Req Client
ProcedureC TestZmqThreadReqProc(vData.i)
  Protected.i Socket = vData
  Protected.i i
  
  PrintN("Connect to Server: " + lpszServerAddr)
  
  For i = 0 To 20
    Define *lpszBuffer = AllocateMemory(32)
    Define lpszMessage.s = "From Client"
    
    ZmqSocket::Send(Socket, lpszMessage, Len(lpszMessage), 0)
    
    Delay(100)
    
    ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszBuffer)
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
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 74
; FirstLine = 40
; Folding = -
; EnableXP
; Executable = ..\..\ModuleThread.exe
; CurrentDirectory = ../../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com