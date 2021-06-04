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

Global lpszServerAddr.s = "tcp://localhost:1700"

Global hLibrary.i = ZmqDllOpen(lpszLibZmqDll)

If hLibrary
  OpenConsole()
  
  Define Context.i = ZmqCtxNew(hLibrary)
  Define Socket.i = ZmqSocket(hLibrary, Context, #ZMQ_REQ)
  Define Rc.i = ZmqConnect(hLibrary, Socket, lpszServerAddr)
  
  PrintN("Connect to Server: " + lpszServerAddr)
  
  Define i.i
  
  For i = 0 To 10 
    Define *lpszBuffer = AllocateMemory(32)
    Define lpszMessage.s = "From Client"
    
    ZmqSend(hLibrary, Socket, lpszMessage, Len(lpszMessage), 0)
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszBuffer)
  Next 
  
  ZmqClose(hLibrary, Socket)
  ZmqCtxShutdown(hLibrary, Context)
  
  Input()
  CloseConsole()
  
  ZmqDllClose(hLibrary)
EndIf
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 11
; Folding = -
; EnableXP
; Executable = ..\ReqClient.exe
; CurrentDirectory = ..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com