;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://localhost:1689"

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Context.i = ZmqContext::New()
  Socket.i = ZmqSocket::Socket(Context, #ZMQ_SUB)
  Rc.i = ZmqSocket::Connect(Socket, lpszServerAddr)
  
  lpszSubscribe.s = "quotes"
  
  ZmqSocket::Setsockopt(Socket, #ZMQ_SUBSCRIBE, lpszSubscribe, Len(lpszSubscribe))
  
;   For i = 0 To 10 
;     *lpszBuffer = AllocateMemory(32)
;     
;     ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
;     
;     PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
;     
;     FreeMemory(*lpszBuffer)
;   Next
  
  While 1
    *lpszTopicBuffer = AllocateMemory(32)
    *lpszBuffer = AllocateMemory(32)
    
    ZmqSocket::Recv(Socket, *lpszTopicBuffer, MemorySize(*lpszTopicBuffer), 0)
    ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszTopicBuffer)
    FreeMemory(*lpszBuffer)
    
    Delay(10)
  Wend   
  
  ZmqSocket::Close(Socket)
  ZmqContext::Shutdown(Context)
  
  Input()
  CloseConsole()
  
  DllClose()
EndIf
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 23
; FirstLine = 6
; EnableXP
; Executable = ModuleSubClient.exe
; CurrentDirectory = ..\..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com