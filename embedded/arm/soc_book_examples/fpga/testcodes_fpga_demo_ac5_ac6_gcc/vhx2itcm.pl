#!/usr/bin/perl -w
#
#-----------------------------------------------------------------------------
#
#            (C) COPYRIGHT 2010-2013 ARM Limited.
#                ALL RIGHTS RESERVED
#
#-----------------------------------------------------------------------------
#

# ==================================================================
# Dividing a hex file to four hex files (one for each byte lane) of
# a 32-bit FPGA I-TCM (Instruction Tightly Coupled Memory)
# ==================================================================

if ($#ARGV < 0) {
    $arg_num = $#ARGV+1;
    print "Only $arg_num argument detected\n";
    die "Usage : vhx2itcm.pl \<verilog_hex_file\>\n";    
    }

$hex_file     = $ARGV[0]; # e.g. hello.hex

open(FPA, "$hex_file")   || die "Cannot open disassembly list file : $!";
open(FPB, ">itcm0")      || die "Cannot open output file           : $!";
open(FPC, ">itcm1")      || die "Cannot open output file           : $!";
open(FPD, ">itcm2")      || die "Cannot open output file           : $!";
open(FPE, ">itcm3")      || die "Cannot open output file           : $!";
$i=0;
while ($currline = <FPA>) {
    chomp($currline);
    $_ = $currline;
    if ($i==0) {print (FPB "$currline\n");}
    if ($i==1) {print (FPC "$currline\n");}
    if ($i==2) {print (FPD "$currline\n");}
    if ($i==3) {print (FPE "$currline\n");}
    $i = $i+1;
    if ($i>3) {$i = 0;}
    }
close (FPA);
close (FPB);
close (FPC);
close (FPD);
close (FPE);

