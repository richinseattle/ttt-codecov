# codecov.js

Time Travel Tracer based DynamoRIO drcov coverage extraction

Forked code from 0vercl0k and ctfhacker

```
C:\code\ttt-codecov>powershell.exe -Command "Measure-Command { cmd.exe /c codecov.bat C:\tools\sysinternals\PsInfo64.exe | Out-Host }"
[codecov] Launching target under Time Travel Tracer: C:\tools\sysinternals\PsInfo64.exe

PsInfo v1.78 - Local and remote system information viewer
Copyright (C) 2001-2016 Mark Russinovich
Sysinternals - www.sysinternals.com

System information for \\BITSURFER:
Uptime:                    2 days 13 hours 7 minutes 30 seconds
Kernel version:            Windows 10 Pro, Multiprocessor Free
Product type:              Professional
Product version:           6.3
Service pack:              0
Kernel build number:       18363
Registered organization:
Registered owner:          rjohnson
IE version:                9.0000
System root:               C:\WINDOWS
Processors:                8
Processor speed:           2.1 GHz
Processor type:            Intel(R) Core(TM) i7-8650U CPU @
Physical memory:           1518 MB
Video driver:              Intel(R) UHD Graphics 620
Microsoft (R) TTTracer 1.01.05
Release: 10.0.18362.1
Copyright (C) Microsoft Corporation. All rights reserved.

Launching C:\tools\sysinternals\PsInfo64.exe

PsInfo64.exe(x64) (PID:8732): Process exited with exit code 0 after 4375ms
  Full trace dumped to C:\tools\sysinternals\PsInfo64.exe.ttt.run

[codecov] Time Travel Trace: "C:\tools\sysinternals\PsInfo64.exe.ttt.run"
[codecov] Extracting code coverage from trace..


Days              : 0
Hours             : 0
Minutes           : 0
Seconds           : 21
Milliseconds      : 656
Ticks             : 216565166
TotalDays         : 0.000250654127314815
TotalHours        : 0.00601569905555556
TotalMinutes      : 0.360941943333333
TotalSeconds      : 21.6565166
TotalMilliseconds : 21656.5166

C:\code\ttt-codecov>bash
rjohnson@bitsurfer:/mnt/c/code/ttt-codecov$ head whoami.exe.ttt.run.whoami.exe.txt
DRCOV VERSION: 2
DRCOV FLAVOR: TTD
Module Table: version 2, count 1
Columns: id, base, end, entry, checksum, timestamp, path
0, 0x7ff715330000, 0x7ff715346000, 0, 0, 0, c:\windows\system32\whoami.exe
BB Table: 3190 bbs
```


--- 

Slightly modified codecov.js from [0vercl0k](https://github.com/0vercl0k/windbg-scripts/blob/master/codecov/codecov.js) to dump the outputfile in drcov format for lighthouse.

`codecov.js` is a [JavaScript](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/javascript-debugger-scripting) debugger extension for WinDbg that allows to extract code-coverage out of a [TTD](https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/time-travel-debugging-overview) trace. It generates a text file with every offsets in a module that have been executed during the recording.

The file looks like the below:

```text
; TracePath: C:\work\codes\blazefox\js01.run
; c:\windows\system32\kernelbase.dll, 7fffb4ce0000, 293000
kernelbase.dll+5df40
kernelbase.dll+5df43
kernelbase.dll+5df47
kernelbase.dll+5df4b
kernelbase.dll+5df4f
...
; c:\windows\system32\kernel32.dll, 7fffb6460000, b3000
kernel32.dll+1f3a0
kernel32.dll+21bb0
kernel32.dll+1bb90
kernel32.dll+1a280
kernel32.dll+1a284
kernel32.dll+1e640
kernel32.dll+63a0
```

## Usage

Run `.scriptload codecov.js` to load the script. You can extract code-coverage using `!codecov "foo"`.

## Examples

Extract code-coverage for every module having `kernel` in their name:

```text
0:000> !codecov "kernel"
Looking for *kernel*..
Found 2 hits
Found 7815 unique addresses in C:\WINDOWS\System32\KERNELBASE.dll
Found 1260 unique addresses in C:\WINDOWS\System32\KERNEL32.DLL
Writing C:\work\codes\tmp\js01.run.kernel.text...
Done!
@$codecov("kernel")

0:000> !codecov "kernel"
Looking for *kernel*..
The output file C:\work\codes\tmp\js01.run.kernel.text already exists, exiting.
@$codecov("kernel")
```

