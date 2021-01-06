;--------------------------------------------------------------------------------------------
;  Copyright (c) Ji-Feng Tsai. All rights reserved.
;  Code released under the MIT license.
;--------------------------------------------------------------------------------------------

; Socket Types
#ZMQ_PAIR   = 0
#ZMQ_PUB    = 1
#ZMQ_SUB    = 2
#ZMQ_REQ    = 3
#ZMQ_REP    = 4
#ZMQ_DEALER = 5
#ZMQ_ROUTER = 6
#ZMQ_PULL   = 7
#ZMQ_PUSH   = 8
#ZMQ_XPUB   = 9
#ZMQ_XSUB   = 10
#ZMQ_STREAM = 11

; Socket Options
#ZMQ_AFFINITY                          = 4
#ZMQ_ROUTING_ID                        = 5
#ZMQ_SUBSCRIBE                         = 6
#ZMQ_UNSUBSCRIBE                       = 7
#ZMQ_RATE                              = 8
#ZMQ_RECOVERY_IVL                      = 9
#ZMQ_SNDBUF                            = 11
#ZMQ_RCVBUF                            = 12
#ZMQ_RCVMORE                           = 13
#ZMQ_FD                                = 14
#ZMQ_EVENTS                            = 15
#ZMQ_TYPE                              = 16
#ZMQ_LINGER                            = 17
#ZMQ_RECONNECT_IVL                     = 18
#ZMQ_BACKLOG                           = 19
#ZMQ_RECONNECT_IVL_MAX                 = 21
#ZMQ_MAXMSGSIZE                        = 22
#ZMQ_SNDHWM                            = 23
#ZMQ_RCVHWM                            = 24
#ZMQ_MULTICAST_HOPS                    = 25
#ZMQ_RCVTIMEO                          = 27
#ZMQ_SNDTIMEO                          = 28
#ZMQ_LAST_ENDPOINT                     = 32
#ZMQ_ROUTER_MANDATORY                  = 33
#ZMQ_TCP_KEEPALIVE                     = 34
#ZMQ_TCP_KEEPALIVE_CNT                 = 35
#ZMQ_TCP_KEEPALIVE_IDLE                = 36
#ZMQ_TCP_KEEPALIVE_INTVL               = 37
#ZMQ_IMMEDIATE                         = 39
#ZMQ_XPUB_VERBOSE                      = 40
#ZMQ_ROUTER_RAW                        = 41
#ZMQ_IPV6                              = 42
#ZMQ_MECHANISM                         = 43
#ZMQ_PLAIN_SERVER                      = 44
#ZMQ_PLAIN_USERNAME                    = 45
#ZMQ_PLAIN_PASSWORD                    = 46
#ZMQ_CURVE_SERVER                      = 47
#ZMQ_CURVE_PUBLICKEY                   = 48
#ZMQ_CURVE_SECRETKEY                   = 49
#ZMQ_CURVE_SERVERKEY                   = 50
#ZMQ_PROBE_ROUTER                      = 51
#ZMQ_REQ_CORRELATE                     = 52
#ZMQ_REQ_RELAXED                       = 53
#ZMQ_CONFLATE                          = 54
#ZMQ_ZAP_DOMAIN                        = 55
#ZMQ_ROUTER_HANDOVER                   = 56
#ZMQ_TOS                               = 57
#ZMQ_CONNECT_ROUTING_ID                = 61
#ZMQ_GSSAPI_SERVER                     = 62
#ZMQ_GSSAPI_PRINCIPAL                  = 63
#ZMQ_GSSAPI_SERVICE_PRINCIPAL          = 64
#ZMQ_GSSAPI_PLAINTEXT                  = 65
#ZMQ_HANDSHAKE_IVL                     = 66
#ZMQ_SOCKS_PROXY                       = 68
#ZMQ_XPUB_NODROP                       = 69
#ZMQ_BLOCKY                            = 70
#ZMQ_XPUB_MANUAL                       = 71
#ZMQ_XPUB_WELCOME_MSG                  = 72
#ZMQ_STREAM_NOTIFY                     = 73
#ZMQ_INVERT_MATCHING                   = 74
#ZMQ_HEARTBEAT_IVL                     = 75
#ZMQ_HEARTBEAT_TTL                     = 76
#ZMQ_HEARTBEAT_TIMEOUT                 = 77
#ZMQ_XPUB_VERBOSER                     = 78
#ZMQ_CONNECT_TIMEOUT                   = 79
#ZMQ_TCP_MAXRT                         = 80
#ZMQ_THREAD_SAFE                       = 81
#ZMQ_MULTICAST_MAXTPDU                 = 84
#ZMQ_VMCI_BUFFER_SIZE                  = 85
#ZMQ_VMCI_BUFFER_MIN_SIZE              = 86
#ZMQ_VMCI_BUFFER_MAX_SIZE              = 87
#ZMQ_VMCI_CONNECT_TIMEOUT              = 88
#ZMQ_USE_FD                            = 89
#ZMQ_GSSAPI_PRINCIPAL_NAMETYPE         = 90
#ZMQ_GSSAPI_SERVICE_PRINCIPAL_NAMETYPE = 91
#ZMQ_BINDTODEVICE                      = 92

; Context Options
#ZMQ_IO_THREADS                 = 1
#ZMQ_MAX_SOCKETS                = 2
#ZMQ_SOCKET_LIMIT               = 3
#ZMQ_THREAD_PRIORITY            = 3
#ZMQ_THREAD_SCHED_POLICY        = 4
#ZMQ_MAX_MSGSZ                  = 5
#ZMQ_MSG_T_SIZE                 = 6
#ZMQ_THREAD_AFFINITY_CPU_ADD    = 7
#ZMQ_THREAD_AFFINITY_CPU_REMOVE = 8
#ZMQ_THREAD_NAME_PREFIX         = 9

; Default for New Contexts
#ZMQ_IO_THREADS_DFLT          = 1
#ZMQ_MAX_SOCKETS_DFLT         = 1023
#ZMQ_THREAD_PRIORITY_DFLT     = -1
#ZMQ_THREAD_SCHED_POLICY_DFLT = -1

; Message Options
#ZMQ_MORE   = 1
#ZMQ_SHARED = 3

; Send/recv Options
#ZMQ_DONTWAIT = 1
#ZMQ_SNDMORE  = 2
; IDE Options = PureBasic 5.72 (Windows - x86)
; CursorPosition = 10
; EnableXP
; IncludeVersionInfo
; VersionField2 = Inwazy Technology
; VersionField3 = PureBasicZMQ
; VersionField4 = 1.0.0