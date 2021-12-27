;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../Core/ZeroMQ.pbi"

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

Global hLibrary.i = ZmqDllOpen(lpszLibZmqDll)

; Rep Server
ProcedureC TestZmqThreadRepProc(vData.i)
  Protected.i Socket = vData
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  While 1    
    Define *lpszBuffer = AllocateMemory(32)
    Define lpszMessage.s = "Hi "
    
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    Delay(10)
    
    PrintN("Received: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    ZmqSend(hLibrary, Socket, lpszMessage, Len(lpszMessage), 0)
       
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
    
    ZmqMsgInit(hLibrary, vMsgRecv1)
    ZmqMsgInit(hLibrary, vMsgRecv2)
    
    vRecv = ZmqMsgRecv(hLibrary, vMsgRecv1, Socket, 0)
    
    If vRecv = -1 Or ZmqErrno(hLibrary) = #ETERM
      Continue
    EndIf
    
    vRecv = ZmqMsgRecv(hLibrary, vMsgRecv2, Socket, 0)
    
    If vRecv = -1 Or ZmqErrno(hLibrary) = #ETERM
      Continue
    EndIf
    
    Define recvData.c = PeekC(ZmqMsgData(hLibrary, vMsgRecv1))
    Define eventId.i = recvData
    Define eventValue.i = PeekC(ZmqMsgData(hLibrary, vMsgRecv1)+SizeOf(recvData))
    Define address.s = PeekS(ZmqMsgData(hLibrary, vMsgRecv2), -1, #PB_UTF8)
    
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
           
    ZmqMsgClose(hLibrary, vMsgRecv1)
    ZmqMsgClose(hLibrary, vMsgRecv2)
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
    
    ZmqSend(hLibrary, Socket, lpszMessage, Len(lpszMessage), 0)
    
    Delay(100)
    
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszBuffer)
  Next
EndProcedure  

If hLibrary
  OpenConsole()
  
  Define ContextRep.i = ZmqCtxNew(hLibrary)
  Define SocketRep.i = ZmqSocket(hLibrary, ContextRep, #ZMQ_REP)
  Define SocketRepMonitor = ZmqSocketMonitor(hLibrary, SocketRep, "inproc://monitor.rep", #ZMQ_EVENT_ACCEPTED + #ZMQ_EVENT_CLOSED)
  Define RcRep.i = ZmqBind(hLibrary, SocketRep, lpszServerAddr)
  
  Define SocketMonitor.i = ZmqSocket(hLibrary, ContextRep, #ZMQ_PAIR)
  Define RcReqMonitor.i = ZmqConnect(hLibrary, SocketMonitor, "inproc://monitor.rep")
  Define threadMonitor.i = ZmqThreadstart(hLibrary, @TestZmqThreadRepMonitorProc(), SocketMonitor)
  
  Define ContextReq.i = ZmqCtxNew(hLibrary)
  Define SocketReq.i = ZmqSocket(hLibrary, ContextReq, #ZMQ_REQ)
  Define RcReq.i = ZmqConnect(hLibrary, SocketReq, lpszServerClientAddr)
  
  Define threadRep.i = ZmqThreadstart(hLibrary, @TestZmqThreadRepProc(), SocketRep)
  Define threadReq.i = ZmqThreadstart(hLibrary, @TestZmqThreadReqProc(), SocketReq)
  
  Input()
  CloseConsole()
  
  ZmqThreadclose(hLibrary, threadMonitor)
  ZmqThreadclose(hLibrary, threadRep)
  ZmqThreadclose(hLibrary, threadReq)
  
  ZmqClose(hLibrary, SocketRep)
  ZmqCtxShutdown(hLibrary, ContextRep)
  
  ZmqClose(hLibrary, SocketReq)
  ZmqCtxShutdown(hLibrary, ContextReq)
  
  ZmqClose(hLibrary, SocketMonitor)
  
  ZmqDllClose(hLibrary)
EndIf
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 47
; FirstLine = 104
; Folding = -
; EnableXP
; Executable = ..\Mointor.exe
; CurrentDirectory = ../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com