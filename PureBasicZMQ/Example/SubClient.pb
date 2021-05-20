;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../Core/ZeroMQ.pbi"

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://localhost:1689"

Global hLibrary.i = ZmqDllOpen(lpszLibZmqDll)

If hLibrary
  OpenConsole()
  
  Define Context.i = ZmqCtxNew(hLibrary)
  Define Socket.i = ZmqSocket(hLibrary, Context, #ZMQ_SUB)
  Define Rc.i = ZmqConnect(hLibrary, Socket, lpszServerAddr)
  
  Define lpszSubscribe.s = "quotes"
  
  ZmqSetsockopt(hLibrary, Socket, #ZMQ_SUBSCRIBE, lpszSubscribe, Len(lpszSubscribe))
  
;   Define i.i
;
;   For i = 0 To 10 
;     Define *lpszBuffer = AllocateMemory(32)
;     
;     ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
;     
;     PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
;     
;     FreeMemory(*lpszBuffer)
;   Next
  
  While 1
    Define *lpszTopicBuffer = AllocateMemory(32)
    Define *lpszBuffer = AllocateMemory(32)
    
    ZmqRecv(hLibrary, Socket, *lpszTopicBuffer, MemorySize(*lpszTopicBuffer), 0)
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszTopicBuffer)
    FreeMemory(*lpszBuffer)
    
    Delay(10)
  Wend   
  
  ZmqClose(hLibrary, Socket)
  ZmqCtxShutdown(hLibrary, Context)
  
  Input()
  CloseConsole()
  
  ZmqDllClose(hLibrary)
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 26
; EnableXP
; Executable = ..\SubClient.exe
; CurrentDirectory = ../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com