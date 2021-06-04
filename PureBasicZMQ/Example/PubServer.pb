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

Global lpszServerAddr.s = "tcp://*:1689"

Global hLibrary.i = ZmqDllOpen(lpszLibZmqDll)

If hLibrary
  OpenConsole()
  
  Define Context.i = ZmqCtxNew(hLibrary)
  Define Socket.i = ZmqSocket(hLibrary, Context, #ZMQ_PUB)
  Define Rc.i = ZmqBind(hLibrary, Socket, lpszServerAddr)
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  While 1
    Define *lpszBuffer = AllocateMemory(32)
    Define lpszTopic.s = "quotes"
    Define lpszMessage.s = "Bid:" + Random(9000, 1000) + ",Ask:" + Random(9000, 1000)
    
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    Delay(10)
    
    Define lpszReturnMessage.s = PeekS(*lpszBuffer, -1, #PB_UTF8)
    
    If lpszReturnMessage <> ""
      PrintN("Received: ")
      PrintN(lpszReturnMessage)
    EndIf
    
    ZmqSend(hLibrary, Socket, lpszTopic, Len(lpszTopic), #ZMQ_SNDMORE)
    ZmqSend(hLibrary, Socket, lpszMessage, Len(lpszMessage), 0)
    
    FreeMemory(*lpszBuffer)
  Wend
  
  ZmqClose(hLibrary, Socket)
  ZmqCtxShutdown(hLibrary, Context)
  
  CloseConsole()
  
  ZmqDllClose(hLibrary)
EndIf
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 11
; Folding = -
; EnableXP
; Executable = ..\PubServer.exe
; CurrentDirectory = ../
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com