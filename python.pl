%
%  python.pl
%  marelle-deps
%

meta_pkg('python-recommended', [
    numpy,
    scipy,
    networkx,
    matplotlib,
    pandas,
    statsmodels,
    virtualenv,
    pip,
    ipython,
    csvkit,
    h5py,
    tables
]).

python_pkg(numpy).
installs_with_apt(numpy, 'python-numpy').
installs_with_brew(numpy).
depends(numpy, osx, ['homebrew-science-tap']).

python_pkg(scipy).
installs_with_apt(scipy, 'python-scipy').
installs_with_brew(scipy).
depends(scipy, _, [gfortran, cython]).
depends(scipy, osx, ['homebrew-science-tap']).

brew_tap('homebrew-science-tap', 'homebrew/science').

command_pkg(virtualenv).
installs_with_pip(virtualenv).

pip_pkg(pandas).
pip_pkg(clint).
pip_pkg(flask).
pip_pkg(anytop).
pip_pkg(networkx).
pip_pkg(csvkit).
pip_pkg(statsmodels).
pip_pkg('nodebox-opengl').
pip_pkg(h5py).
pip_pkg(tables).

command_pkg(ipython).
installs_with_apt(ipython).
meet(ipython, osx) :- install_pip(ipython).
depends(ipython, osx, [pip]).

%  Vincent: a python to vega translator for charting
%  https://github.com/wrobstory/vincent/
python_pkg(vincent).
meet(vincent, _) :- install_pip('https://github.com/wrobstory/vincent/archive/master.zip').

python_pkg(matplotlib).
installs_with_apt(matplotlib, 'python-matplotlib').
installs_with_brew(matplotlib).
depends(matplotlib, osx, ['homebrew-samueljohn-tap']).

command_pkg(pypy).
installs_with_brew(pypy).

pip_pkg(pyaudio).
depends(pyaudio, _, [portaudio]).

managed_pkg(portaudio).

command_pkg(fabric, fab).
installs_with_pip(fabric).
