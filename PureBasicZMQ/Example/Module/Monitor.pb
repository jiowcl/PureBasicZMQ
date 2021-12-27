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

; Rep Server Monitor
ProcedureC TestZmqThreadRepMonitorProc(vData.i)
  Protected.i Socket = vData
  Protected.i i
  
  PrintN("Connect to Monitor Server: " + lpszServerAddr)
  
  While 1
    Define vMsgRecv1.ZmqMsgT
    Define vMsgRecv2.ZmqMsgT
    Define vRecv.i
    
    ZmqMsg::Init(vMsgRecv1)
    ZmqMsg::Init(vMsgRecv2)
    
    vRecv = ZmqMsg::Recv(vMsgRecv1, Socket, 0)
    
    If vRecv = -1 Or ZmqRuntime::Errno() = #ETERM
      Continue
    EndIf
    
    vRecv = ZmqMsg::Recv(vMsgRecv2, Socket, 0)
    
    If vRecv = -1 Or ZmqRuntime::Errno() = #ETERM
      Continue
    EndIf
    
    Define recvData.c = PeekC(ZmqMsg::ZData(vMsgRecv1))
    Define eventId.i = recvData
    Define eventValue.i = PeekC(ZmqMsg::ZData(vMsgRecv1)+SizeOf(recvData))
    Define address.s = PeekS(ZmqMsg::ZData(vMsgRecv2), -1, #PB_UTF8)
    
    Select eventId
      Case #ZMQ_EVENT_ACCEPTED
        PrintN("Event #ZMQ_EVENT_ACCEPTED")
        PrintN("Event Value: " + eventValue)
        PrintN("Address: " + address)
      Case #ZMQ_EVENT_CLOSED
        PrintN("Event #ZMQ_EVENT_CLOSED")
        PrintN("Event Value: " + eventValue)
        PrintN("Address: " + address)
    EndSelect
        
    ZmqMsg::Close(vMsgRecv1)
    ZmqMsg::Close(vMsgRecv2)
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
  Define SocketRepMonitor = ZmqSocket::SocketMonitor(SocketRep, "inproc://monitor.rep", #ZMQ_EVENT_ACCEPTED + #ZMQ_EVENT_CLOSED)
  Define RcRep.i = ZmqSocket::Bind(SocketRep, lpszServerAddr)
  
  Define SocketMonitor.i = ZmqSocket::Socket(ContextRep, #ZMQ_PAIR)
  Define RcReqMonitor.i = ZmqSocket::Connect(SocketMonitor, "inproc://monitor.rep")
  Define threadMonitor.i = ZmqHelper::Threadstart(@TestZmqThreadRepMonitorProc(), SocketMonitor)
  
  Define ContextReq.i = ZmqContext::New()
  Define SocketReq.i = ZmqSocket::Socket(ContextReq, #ZMQ_REQ)
  Define RcReq.i = ZmqSocket::Connect(SocketReq, lpszServerClientAddr)
  
  Define threadRep.i = ZmqHelper::Threadstart(@TestZmqThreadRepProc(), SocketRep)
  Define threadReq.i = ZmqHelper::Threadstart(@TestZmqThreadReqProc(), SocketReq)
  
  Input()
  CloseConsole()
  
  ZmqHelper::Threadclose(threadMonitor)
  ZmqHelper::Threadclose(threadRep)
  ZmqHelper::Threadclose(threadReq)
  
  ZmqSocket::Close(SocketRep)
  ZmqContext::Shutdown(ContextRep)
  
  ZmqSocket::Close(SocketReq)
  ZmqContext::Shutdown(ContextReq)
  
  DllClose()
EndIf
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 130
; FirstLine = 96
; Folding = -
; EnableXP
; Executable = ..\..\ModuleMonitor.exe
; CurrentDirectory = ../../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com