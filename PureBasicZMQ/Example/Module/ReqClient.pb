﻿;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://localhost:1700"

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Context.i = ZmqContext::New()
  Socket.i = ZmqSocket::Socket(Context, #ZMQ_REQ)
  Rc.i = ZmqSocket::Connect(Socket, lpszServerAddr)
  
  PrintN("Connect to Server: " + lpszServerAddr)
  
  For i = 0 To 10 
    *lpszBuffer = AllocateMemory(32)
    lpszMessage.s = "From Client"
    
    ZmqSocket::Send(Socket, lpszMessage, Len(lpszMessage), 0)
    ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszBuffer)
  Next 
  
  ZmqSocket::Close(Socket)
  ZmqContext::Shutdown(Context)
  
  Input()
  CloseConsole()
  
  DllClose()
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 36
; EnableXP
; Executable = ModuleReqClient.exe
; CurrentDirectory = ..\..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com