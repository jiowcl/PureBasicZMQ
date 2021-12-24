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
    
    ZmqMsgInit(hLibrary, vMsgRecv)
    ZmqMsgInit(hLibrary, vMsgSend)
    ZmqMsgInitSize(hLibrary, vMsgSend, 32)
    
    PokeS(ZmqMsgData(hLibrary, vMsgSend), "Hi ", -1, #PB_UTF8)
    
    ZmqMsgRecv(hLibrary, vMsgRecv, Socket, 0)
    
    Delay(10)
    
    PrintN("Received: ")
    PrintN( PeekS(ZmqMsgData(hLibrary, vMsgRecv), -1, #PB_UTF8) )
    
    ZmqMsgSend(hLibrary, vMsgSend, Socket, 0)
    
    ZmqMsgClose(hLibrary, vMsgRecv)
    ZmqMsgClose(hLibrary, vMsgSend)
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
    
    ZmqMsgInit(hLibrary, vMsgRecv)
    ZmqMsgInit(hLibrary, vMsgSend)
    ZmqMsgInitSize(hLibrary, vMsgSend, 32)
    
    PokeS(ZmqMsgData(hLibrary, vMsgSend), "From Client", -1, #PB_UTF8)
    
    ZmqMsgSend(hLibrary, vMsgSend, Socket, 0)
    
    Delay(100)
    
    ZmqMsgRecv(hLibrary, vMsgRecv, Socket, 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(ZmqMsgData(hLibrary, vMsgRecv), -1, #PB_UTF8) )
    
    ZmqMsgClose(hLibrary, vMsgRecv)
    ZmqMsgClose(hLibrary, vMsgSend)
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
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 49
; FirstLine = 37
; Folding = -
; EnableXP
; Executable = ..\Msg.exe
; CurrentDirectory = ../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com