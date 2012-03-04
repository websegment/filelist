#!/usr/bin/perl
# Example
# ./fileinfo.pl targetdir > filelist.txt
use strict;
my @chown;
my @chmod;
 
#ディレクトリの指定
my $directory = $ARGV[0];
my @filelist = `find $directory -ls`;
foreach my $file(@filelist){
	$file =~s/\s+/\t/g;
	my @info = split(/\t/, $file);
	#ファイルのステータスを取得
	my @status = stat $info[10];
	#パーミッションを8進数に変換
	my $permission = substr((sprintf "%03o", $status[2]), -3);

	my $chownCommand = sprintf("chown %s:%s %s\n",
		$info[4], $info[5], $info[10]);
	my $chmodCommand = sprintf("chmod %s %s\n",
		$permission, $info[10]);
	push(@chown, $chownCommand);
	push(@chmod, $chmodCommand);
}
foreach my $command(@chown){
	print $command;
}
foreach my $command(@chmod){
	print $command;
}