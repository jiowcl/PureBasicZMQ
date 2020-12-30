# PureBasicZMQ

ZMQ Wrapper for PureBasic Programming Language.

![GitHub](https://img.shields.io/github/license/jiowcl/PureBasicZMQ.svg)

## Environment

- Windows 7 above (recommend)
- PureBasic 5.0 above (recommend)
- [ZeroMQ](https://github.com/zeromq)

## How to Build

Building requires PureBasic Compiler and test under Windows 10.

## Example

Rep Server

```purebasic
IncludeFile "../Core/ZeroMQ.pbi"

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://*:1700"

Global hLibrary = ZmqDllOpen(lpszLibZmqDll)

If hLibrary
  OpenConsole()
  
  Context.i = ZmqCtxNew(hLibrary)
  Socket.i = ZmqSocket(hLibrary, Context, #ZMQ_REP)
  Rc.i = ZmqBind(hLibrary, Socket, lpszServerAddr)
  
  PrintN("Bind an IP address: " + lpszServerAddr)
  
  lTotal.l = 0
  
  While 1
    *lpszBuffer = AllocateMemory(32)
    lTotal = lTotal + 1
    lpszMessage.s = "Hi " + lTotal
    
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    Delay(10)
    
    PrintN("Received: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    ZmqSend(hLibrary, Socket, lpszMessage, Len(lpszMessage), 0)
    
    FreeMemory(*lpszBuffer)
  Wend
  
  ZmqClose(hLibrary, Socket)
  ZmqCtxShutdown(hLibrary, Socket)
  
  CloseConsole()
  
  ZmqDllClose(hLibrary)
EndIf
```

Req Client

```purebasic
IncludeFile "../Core/ZeroMQ.pbi"

Global lpszLibZmqDll.s = "libzmq.dll"
Global lpszServerAddr.s = "tcp://localhost:1700"

Global hLibrary = ZmqDllOpen(lpszLibZmqDll)

If hLibrary
  OpenConsole()
  
  Context.i = ZmqCtxNew(hLibrary)
  Socket.i = ZmqSocket(hLibrary, Context, #ZMQ_REQ)
  Rc.i = ZmqConnect(hLibrary, Socket, lpszServerAddr)
  
  PrintN("Connect to Server: " + lpszServerAddr)
  
  For i = 0 To 10 
    *lpszBuffer = AllocateMemory(32)
    lpszMessage.s = "From Client"
    
    ZmqSend(hLibrary, Socket, lpszMessage, Len(lpszMessage), 0)
    ZmqRecv(hLibrary, Socket, *lpszBuffer, MemorySize(*lpszBuffer), 0)
    
    PrintN("Reply From Server: ")
    PrintN( PeekS(*lpszBuffer, -1, #PB_UTF8) )
    
    FreeMemory(*lpszBuffer)
  Next 
  
  ZmqClose(hLibrary, Socket)
  ZmqCtxShutdown(hLibrary, Socket)
  
  Input()
  CloseConsole()
  
  ZmqDllClose(hLibrary)
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
