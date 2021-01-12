﻿;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://*:1700"

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Context.i = ZmqContext::New()
  Socket.i = ZmqSocket::Socket(Context, #ZMQ_REP)
  Rc.i = ZmqSocket::Bind(Socket, lpszServerAddr)
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  lTotal.l = 0
  
  While 1
    *lpszBuffer = AllocateMemory(32)
    lTotal = lTotal + 1
    lpszMessage.s = "Hi " + lTotal
    
    ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    Delay(10)
    
    PrintN("Received: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    ZmqSocket::Send(Socket, lpszMessage, Len(lpszMessage), 0)
    
    FreeMemory(*lpszBuffer)
  Wend
  
  ZmqSocket::Close(Socket)
  ZmqContext::Shutdown(Context)
  
  CloseConsole()
  
  DllClose()
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 42
; EnableXP
; Executable = ModuleRepServer.exe
; CurrentDirectory = ..\..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com