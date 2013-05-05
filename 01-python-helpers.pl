%
%  01-python-helpers.pl
%  marelle-deps
%

% python_pkg(-Pkg) is nondet.
%   Pkg is a python module imported using the same name.
:- multifile python_pkg/1.

% python_pkg(-Pkg, -ImportName) is nondet.
%   Pkg is a python module imported by a different name.
:- multifile python_pkg/2.

% pip_pkg(-Pkg) is nondet.
%   Pkg is a python module installable with pip.
:- multifile pip_pkg/1.

%  All python packages are packages.
pkg(P) :- python_pkg(P, _).

%  If it's a Python package, it's met if you can import it.
met(P, _) :-
    python_pkg(P, ImportName), !,
    python_import(ImportName).

python_pkg(P, P) :- python_pkg(P).

% python_import(+Pkg) is semidet.
%   Try to import the module in Python, failing if the import fails.
python_import(Pkg) :-
    bash(['python -c \'import ', Pkg, '\' >/dev/null 2>/dev/null']).

%  All python packages depend on Python.
depends(P, _, [python]) :-
    python_pkg(P).

%  All pip packages are also packages.
pkg(P) :- pip_pkg(P).

%  all pip packages depend on pip
depends(P, _, [pip]) :- pip_pkg(P).

met(P, _) :-
    pip_pkg(P), !,
    bash(['pip freeze 2>/dev/null | cut -d \'=\' -f 1 | fgrep -qi ', P]).

%  meet pip packages on any platform by installing them with pip
meet(P, _) :-
    pip_pkg(P), !,
    install_pip(P).

% install_pip(+Pkg) is semidet.
%   Try to install the pacakge with pip, maybe using sudo.
install_pip(Pkg) :-
    which(pip, Pip),
    atom_concat(Parent, '/pip', Pip),
    ( access_file(Parent, write) ->
        Sudo = ''
    ;
        Sudo = 'sudo '
    ),
    join(['Installing ', Pkg, ' with pip'], Msg),
    writeln(Msg),
    bash(['umask a+rx && ', Sudo, 'pip install -U ', Pkg]).
