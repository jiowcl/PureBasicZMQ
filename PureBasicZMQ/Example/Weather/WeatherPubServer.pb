;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://*:1692"

Global lpszJsonWeather.s = ""

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  InitNetwork()
  
  Print("Enter OpenWeatherMap API Key and Press Return: ")
  Define WeatherApiKey.s = Input()
  
  Define HttpRequest = HTTPRequest(#PB_HTTP_Get, "https://api.openweathermap.org/data/2.5/weather?q=Taiwan&appid=" + WeatherApiKey)
  
  If HttpRequest
    lpszJsonWeather = HTTPInfo(HTTPRequest, #PB_HTTP_Response)
    
    FinishHTTP(HTTPRequest)
  EndIf
  
  Define Context.i = ZmqContext::New()
  Define Socket.i = ZmqSocket::Socket(Context, #ZMQ_PUB)
  Define Rc.i = ZmqSocket::Bind(Socket, lpszServerAddr)
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  While 1
    Define *lpszBuffer = AllocateMemory(32)
    Define lpszTopic.s = "weather"
    Define lpszMessage.s = lpszJsonWeather
    
    ZmqSocket::Recv(Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    Delay(10)
    
    Define lpszReturnMessage.s = PeekS(*lpszBuffer, -1, #PB_UTF8)
    
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
; CursorPosition = 47
; EnableXP
; Executable = ..\..\ModuleWeatherPubServer.exe
; CurrentDirectory = ..\..\
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField9 = Ji-Feng Tsai
; VersionField13 = jiowcl@gmail.com