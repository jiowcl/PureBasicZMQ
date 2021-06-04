;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

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

Global lpszServerAddr.s = "tcp://localhost:1692"

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Define Context.i = ZmqContext::New()
  Define Socket.i = ZmqSocket::Socket(Context, #ZMQ_SUB)
  Define Rc.i = ZmqSocket::Connect(Socket, lpszServerAddr)
  
  Define lpszSubscribe.s = "weather"
  
  ZmqSocket::Setsockopt(Socket, #ZMQ_SUBSCRIBE, lpszSubscribe, Len(lpszSubscribe))
  
  While 1
    Define *lpszTopicBuffer = AllocateMemory(1024)
    Define *lpszBuffer = AllocateMemory(1024)
    
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
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 14
; Folding = -
; EnableXP
; Executable = ..\..\ModuleWeatherSubClient.exe
; CurrentDirectory = ..\..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com