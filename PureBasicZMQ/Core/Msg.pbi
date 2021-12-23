;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Prototype Function
PrototypeC.i ZmqMsgInitFunc(*msg.ZmqMsgT)
PrototypeC.i ZmqMsgInitSizeFunc(*msg.ZmqMsgT, size.i)
PrototypeC.i ZmqMsgInitDataFunc(*msg.ZmqMsgT, vData.i, size.i, *ffn.ZmqFreeFnProc, hint.i)
PrototypeC.i ZmqMsgSendFunc(*msg.ZmqMsgT, socket.i, flags.i)
PrototypeC.i ZmqMsgRecvFunc(*msg.ZmqMsgT, socket.i, flags.i)
PrototypeC.i ZmqMsgCloseFunc(*msg.ZmqMsgT)
PrototypeC.i ZmqMsgMoveFunc(*destmsg.ZmqMsgT, *srcmsg.ZmqMsgT)
PrototypeC.i ZmqMsgCopyFunc(*destmsg.ZmqMsgT, *srcmsg.ZmqMsgT)
PrototypeC.i ZmqMsgDataFunc(*msg.ZmqMsgT)
PrototypeC.i ZmqMsgSizeFunc(*msg.ZmqMsgT)
PrototypeC.i ZmqMsgMoreFunc(*msg.ZmqMsgT)
PrototypeC.i ZmqMsgGetFunc(*msg.ZmqMsgT, property.i)
PrototypeC.i ZmqMsgSetFunc(*msg.ZmqMsgT, property.i, optval.i)
PrototypeC.i ZmqMsgGetsFunc(*msg.ZmqMsgT, property.p-Ascii)

; Zmq Function Declare

; <summary>
; ZmqMsgInit
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgInit(dllInstance.i, *msg.ZmqMsgT)
  Protected.i lResult
  Protected.ZmqMsgInitFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_init")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgInitSize
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <param name="size"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgInitSize(dllInstance.i, *msg.ZmqMsgT, size.i)
  Protected.i lResult
  Protected.ZmqMsgInitSizeFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_init_size")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg, size)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgInitData
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <param name="vdata"></param>
; <param name="size"></param>
; <param name="*ffn"></param>
; <param name="hint"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgInitData(dllInstance.i, *msg.ZmqMsgT, vdata.i, size.i, *ffn.ZmqFreeFnProc, hint.i)
  Protected.i lResult
  Protected.ZmqMsgInitDataFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_init_data")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg, vdata, size, *ffn, hint)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgSend
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <param name="socket"></param>
; <param name="flags"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgSend(dllInstance.i, *msg.ZmqMsgT, socket.i, flags.i)
  Protected.i lResult
  Protected.ZmqMsgSendFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_send")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg.ZmqMsgT, socket, flags)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgRecv
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <param name="socket"></param>
; <param name="flags"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgRecv(dllInstance.i, *msg.ZmqMsgT, socket.i, flags.i)
  Protected.i lResult
  Protected.ZmqMsgRecvFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_recv")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg.ZmqMsgT, socket, flags)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgClose
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgClose(dllInstance.i, *msg.ZmqMsgT)
  Protected.i lResult
  Protected.ZmqMsgCloseFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_close")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg.ZmqMsgT)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgMove
; </summary>
; <param name="dllInstance"></param>
; <param name="*destmsg"></param>
; <param name="*srcmsg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgMove(dllInstance.i, *destmsg.ZmqMsgT, *srcmsg.ZmqMsgT)
  Protected.i lResult
  Protected.ZmqMsgMoveFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_move")
    
    If pFuncCall > 0
      lResult = pFuncCall(*destmsg, *srcmsg)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgCopy
; </summary>
; <param name="dllInstance"></param>
; <param name="*destmsg"></param>
; <param name="*srcmsg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgCopy(dllInstance.i, *destmsg.ZmqMsgT, *srcmsg.ZmqMsgT)
  Protected.i lResult
  Protected.ZmqMsgCopyFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_copy")
    
    If pFuncCall > 0
      lResult = pFuncCall(*destmsg, *srcmsg)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgData
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgData(dllInstance.i, *msg.ZmqMsgT)
  Protected.i lResult
  Protected.ZmqMsgDataFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_data")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgSize
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgSize(dllInstance.i, *msg.ZmqMsgT)
  Protected.i lResult
  Protected.ZmqMsgSizeFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_size")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgMore
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgMore(dllInstance.i, *msg.ZmqMsgT)
  Protected.i lResult
  Protected.ZmqMsgMoreFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_more")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgGet
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <param name="property"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgGet(dllInstance.i, *msg.ZmqMsgT, property.i)
  Protected.i lResult
  Protected.ZmqMsgGetFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_get")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg, property)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgSet
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <param name="property"></param>
; <param name="optval"></param>
; <returns>Returns integer.</returns>
Procedure.i ZmqMsgSet(dllInstance.i, *msg.ZmqMsgT, property.i, optval.i)
  Protected.i lResult
  Protected.ZmqMsgSetFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_set")
    
    If pFuncCall > 0
      lResult = pFuncCall(*msg, property, optval)
    EndIf
  EndIf
  
  ProcedureReturn lResult
EndProcedure

; <summary>
; ZmqMsgGets
; </summary>
; <param name="dllInstance"></param>
; <param name="*msg"></param>
; <param name="property"></param>
; <returns>Returns string.</returns>
Procedure.s ZmqMsgGets(dllInstance.i, *msg.ZmqMsgT, property.s)
  Protected.s lResult
  Protected.i lResultAddress
  Protected.ZmqMsgGetsFunc pFuncCall
  
  If IsLibrary(dllInstance)
    pFuncCall = GetFunction(dllInstance, "zmq_msg_gets")
    
    If pFuncCall > 0
      lResultAddress = pFuncCall(*msg, property)
      
      If lResultAddress > 0
        lResult = PeekS(lResultAddress, -1, #PB_UTF8)
      EndIf  
    EndIf  
  EndIf
  
  ProcedureReturn lResult
EndProcedure
; IDE Options = PureBasic 5.72 (Windows - x64)
; CursorPosition = 19
; Folding = ---
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0