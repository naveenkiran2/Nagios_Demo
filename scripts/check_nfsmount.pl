#!/usr/bin/perl -wI.
# Usage: check_nfsmount
# Description:
#	This script determines whether there
#	are stale NFS mounts on the host.

open  FD,">/tmp/nfsCheck";
print FD "#!/bin/bash\ncd \$1 || { exit 2; }\nexit 0;\n";
close FD;

system("chmod +x /tmp/nfsCheck");

$dirs = `mount | grep " type nfs " | awk '{print \$3}'`;
foreach $mtpt (split(/\n/,$dirs)) {
  system("/tmp/nfsCheck $mtpt &");
  system("sleep 0.3");
  chomp($proc = `ps -ef | grep nfsCheck | grep -v grep | awk '{print \$2}'`);
  if ("$proc" ne "") {
    print "NFS CRITICAL:  Stale NFS mount point - $mtpt.\n";
    system("kill -9 $proc");
    exit 2;
  }
}

print "NFS OK:  All mounts available.\n";
exit 0;
