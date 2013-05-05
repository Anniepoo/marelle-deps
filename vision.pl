%
%  vision.pl
%  marelle-deps
%
%  Support for computer vision.
%

python_pkg('python-opencv', opencv).
installs_with_apt('python-opencv').
depends('python-opencv', osx, opencv).

meta_pkg(simplecv, [
    'python-opencv',
    pygame,
    ipython,
    numpy,
    scipy,
    '__simplecv code checked out',
    '__simplecv installed'
]).

git_step(
    '__simplecv code checked out',
    'https://github.com/sightmachine/SimpleCV',
    '~/.local/SimpleCV'
).

python_pkg(pygame).
installs_with_apt(pygame, 'python-pygame').
installs_with_brew(pygame).
depends(pygame, osx, [
    'homebrew-headonly-tap',
    'homebrew-samueljohn-tap'
]).

brew_tap('homebrew-headonly-tap', 'homebrew/headonly').
brew_tap('homebrew-samueljohn-tap', 'samueljohn/python').

pkg(opencv).
installs_with_brew(opencv).
installs_with_apt(opencv, 'libopencv-dev').

python_pkg('__simplecv installed', 'SimpleCV').
meet('__simplecv installed', _) :-
    which(python, Python),
    atom_concat(Parent, '/python', Python),
    ( access_file(Parent, write) ->
        Sudo = ''
    ;
        Sudo = 'sudo '
    ),
    join(['umask a+rx && cd ~/.local/SimpleCV && ', Sudo, 'python setup.py develop'], Cmd),
    bash(Cmd).

pip_pkg(cython).
