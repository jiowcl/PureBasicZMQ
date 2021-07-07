# PureBasicZMQ

ZMQ Wrapper for PureBasic Programming Language.

![GitHub](https://img.shields.io/github/license/jiowcl/PureBasicZMQ.svg)

## Environment

- Windows 7 above (recommend)  
- PureBasic 5.0 above (recommend)  
- [ZeroMQ](https://github.com/zeromq)  

## How to Build

Building requires PureBasic Compiler and test under Windows 10.  
Module features require PureBasic 5.20 and above.

## Example

Publisher Server

```purebasic
EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://*:1689"

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Define Context.i = ZmqContext::New()
  Define Socket.i = ZmqSocket::Socket(Context, #ZMQ_PUB)
  Define Rc.i = ZmqSocket::Bind(Socket, lpszServerAddr)
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  While 1
    Define *lpszBuffer = AllocateMemory(32)
    Define lpszTopic.s = "quotes"
    Define lpszMessage.s = "Bid:" + Random(9000, 1000) + ",Ask:" + Random(9000, 1000)
    
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
```

Subscribe Client

```purebasic
EnableExplicit

IncludeFile "../../Core/Enums.pbi"
IncludeFile "../../Core/ZeroMQWrapper.pbi"

UseModule ZeroMQWrapper

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://localhost:1689"

If DllOpen(lpszLibZmqDll)
  OpenConsole()
  
  Define Context.i = ZmqContext::New()
  Define Socket.i = ZmqSocket::Socket(Context, #ZMQ_SUB)
  Define Rc.i = ZmqSocket::Connect(Socket, lpszServerAddr)
  
  Define lpszSubscribe.s = "quotes"
  
  ZmqSocket::Setsockopt(Socket, #ZMQ_SUBSCRIBE, lpszSubscribe, Len(lpszSubscribe))
  
  While 1
    Define *lpszTopicBuffer = AllocateMemory(32)
    Define *lpszBuffer = AllocateMemory(32)
    
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
```

## License

Copyright (c) 2017-2021 Ji-Feng Tsai.  
Code released under the MIT license.  

## TODO

- More examples  

## Donation

If this application help you reduce time to coding, you can give me a cup of coffee :)

[![paypal](https://www.paypalobjects.com/en_US/TW/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=3RNMD6Q3B495N&source=url)

[Paypal Me](https://paypal.me/jiowcl?locale.x=zh_TW)
