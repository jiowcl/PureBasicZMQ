﻿;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://*:1689"

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Context.i = ZmqContext::New()
  Socket.i = ZmqSocket::Socket(Context, #ZMQ_PUB)
  Rc.i = ZmqSocket::Bind(Socket, lpszServerAddr)
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  While 1
    *lpszBuffer = AllocateMemory(32)
    lpszTopic.s = "quotes"
    lpszMessage.s = "Bid:" + Random(9000, 1000) + ",Ask:" + Random(9000, 1000)
    
    ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    Delay(10)
    
    lpszReturnMessage.s = PeekS(*lpszBuffer, -1, #PB_UTF8)
    
    If lpszReturnMessage <> ""
      PrintN("Received: ")
      PrintN(lpszReturnMessage)
    EndIf
    
    ZmqSocket::Send(Socket, lpszTopic, Len(lpszTopic), #ZMQ_SNDMORE)
    ZmqSocket::Send(Socket, lpszMessage, Len(lpszMessage), 0)
    
    FreeMemory(*lpszBuffer)
  Wend
  
  ZmqSocket::Close(Socket)
  ZmqContext::Shutdown(Context)
  
  CloseConsole()
  
  DllClose()
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 4
; EnableXP
; Executable = ModulePubServer.exe
; CurrentDirectory = ..\..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com