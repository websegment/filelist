#!/usr/bin/perl
# Example
# ./fileinfo.pl targetdir > filelist.txt
use strict;
my @chown;
my @chmod;
 
# Directory
my $directory = $ARGV[0];
my @filelist = `find $directory -ls`;
foreach my $file(@filelist){
	$file =~s/\s+/\t/g;
	my @info = split(/\t/, $file);
	my $user = $info[4];
	my $group = $info[5];
	my $filepath = $info[10];
	$filepath =~ s/\'/\\'/ig;
	$filepath =~ s/\"/\\"/ig;
	$filepath =~ s/\(/\\(/ig;
	$filepath =~ s/\)/\\)/ig;
	$filepath =~ s/\>/\\>/ig;
	$filepath =~ s/\</\\</ig;
	$filepath =~ s/\{/\\{/ig;
	$filepath =~ s/\}/\\}/ig;
	$filepath =~ s/\[/\\[/ig;
	$filepath =~ s/\]/\\]/ig;
	$filepath =~ s/\|/\\|/ig;
	$filepath =~ s/\=/\\=/ig;
	$filepath =~ s/\`/\\`/ig;
	$filepath =~ s/\@/\\@/ig;
	$filepath =~ s/\:/\\:/ig;
	$filepath =~ s/\*/\\*/ig;
	$filepath =~ s/\?/\\?/ig;
	$filepath =~ s/\&/\\&/ig;
	$filepath =~ s/\!/\\!/ig;

	# Get file status.
	my @status = stat $info[10];
	# Convert permission
	my $permission = substr((sprintf "%03o", $status[2]), -3);

	my $chownCommand = sprintf("chown %s:%s %s\n",
		$user, $group, $filepath);
	my $chmodCommand = sprintf("chmod %s %s\n",
		$permission, $filepath);
	push(@chown, $chownCommand);
	push(@chmod, $chmodCommand);
}
foreach my $command(@chown){
	print $command;
}
foreach my $command(@chmod){
	print $command;
}
