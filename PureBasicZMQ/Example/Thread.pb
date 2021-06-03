;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../Core/ZeroMQ.pbi"

Global lpszLibZmqDll.s = "libzmq.dll"
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
  Define RcRep.i = ZmqBind(hLibrary, SocketRep, lpszServerAddr)
  
  Define ContextReq.i = ZmqCtxNew(hLibrary)
  Define SocketReq.i = ZmqSocket(hLibrary, ContextReq, #ZMQ_REQ)
  Define RcReq.i = ZmqConnect(hLibrary, SocketReq, lpszServerClientAddr)
    
  Define threadRep.i = ZmqThreadstart(hLibrary, @TestZmqThreadRepProc(), SocketRep)
  Define threadReq.i = ZmqThreadstart(hLibrary, @TestZmqThreadReqProc(), SocketReq)
  
  Input()
  CloseConsole()
  
  ZmqThreadclose(hLibrary, threadRep)
  ZmqThreadclose(hLibrary, threadReq)
  
  ZmqClose(hLibrary, SocketRep)
  ZmqCtxShutdown(hLibrary, ContextRep)
  
  ZmqClose(hLibrary, SocketReq)
  ZmqCtxShutdown(hLibrary, ContextReq)
  
  ZmqDllClose(hLibrary)
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 72
; FirstLine = 39
; Folding = -
; EnableXP
; Executable = ..\Thread.exe
; CurrentDirectory = ../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com