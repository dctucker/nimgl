# Copyright (C) CleverByte. All Rights Reserved
# Written by Leonardo Mariscal <cavariux@cleverbyte.io>, 2018

## OpenGL Bindings
## ====
## `return <../>`_.  
##
## This bindings follow most of the original library
## You can check the original documentation `here <http://www.glfw.org/docs/latest/>`_.

type
  ProcGL*  = ptr object

when defined(windows):
  const
    wingdi_h  = "<wingdi.h>"
    winbase_h = "<Winbase.h>"
  type
    #PFNGLCLEARCOLORXOESPROC = ptr object {.importc: ""
    HInstance* = ptr object {.importc: "HINSTANCE", header: winbase_h.}
  proc wglGetProcAddress(procgl: cstring): ProcGL {.importc, header: wingdi_h.}
  proc LoadLibrary(procgl: cstring): HInstance {.importc, header: winbase_h.}
  proc GetProcAddress(module: HInstance, procgl: cstring): ProcGL {.importc, header: winbase_h.}
elif defined(macosx):
  const
    dyld_h = "<mach-o/dyld.h>"

proc getProcGL*(procgl: cstring): ProcGL =
  when defined(windows):
    result = wglGetProcAddress(procgl)
    if result == nil:
      var ogl32: HInstance = LoadLibrary("opengl32.dll")
      result = GetProcAddress(ogl32, procgl)
  elif defined(macosx):
    echo procgl

proc init*() =
  echo repr(getProcGL("glClearColor"))
  echo repr(getProcGL("glClear"))