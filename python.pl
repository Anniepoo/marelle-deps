%
%  python.pl
%  marelle-deps
%

command_pkg(python).

command_pkg(pip).
installs_with_apt(pip, python-pip).
depends(pip, _, [python]).

python_pkg(numpy).
python_pkg(scipy).
python_pkg('SimpleCV').
python_pkg(matplotlib).
python_pkg(networkx).

pip_pkg(pandas).
pip_pkg(virtualenv).
pip_pkg(clint).
pip_pkg(flask).
pip_pkg(distribute).
pip_pkg(anytop).

command_pkg(ipython).
installs_with_apt(ipython).
meet(ipython, osx) :- install_pip(ipython).
depends(ipython, osx, [pip]).
