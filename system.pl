%
%  system.pl
%  marelle-deps
%
%  Basic system utility packages.
%

managed_pkg(htop).
managed_pkg(mercurial).
managed_pkg(screen).

command_pkg(pstree).
installs_with_brew(pstree).
installs_with_apt(pstree, psmisc).
