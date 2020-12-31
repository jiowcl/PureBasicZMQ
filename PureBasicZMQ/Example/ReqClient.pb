;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../Core/ZeroMQ.pbi"

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://localhost:1700"

Global hLibrary = ZmqDllOpen(lpszLibZmqDll)

If hLibrary
  OpenConsole()
  
  Context.i = ZmqCtxNew(hLibrary)
  Socket.i = ZmqSocket(hLibrary, Context, #ZMQ_REQ)
  Rc.i = ZmqConnect(hLibrary, Socket, lpszServerAddr)
  
  PrintN("Connect to Server: " + lpszServerAddr)
  
  For i = 0 To 10 
    *lpszBuffer = AllocateMemory(32)
    lpszMessage.s = "From Client"
    
    ZmqSend(hLibrary, Socket, lpszMessage, Len(lpszMessage), 0)
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszBuffer)
  Next 
  
  ZmqClose(hLibrary, Socket)
  ZmqCtxShutdown(hLibrary, Socket)
  
  Input()
  CloseConsole()
  
  ZmqDllClose(hLibrary)
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 9
; EnableXP
; Executable = ReqClient.exe
; CurrentDirectory = ..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com