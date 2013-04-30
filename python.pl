%
%  python.pl
%  marelle-deps
%

python_import(Pkg) :-
    join(['python -c \'import ', Pkg, '\' 2>/dev/null'], Cmd),
    shell(Cmd, 0).

pkg(pandas).
detect(pandas, _) :- python_import(pandas).

pkg(numpy).
detect(numpy, _) :- python_import(numpy).

pkg(scipy).
detect(scipy, _) :- python_import(scipy).

pkg('SimpleCV').
detect('SimpleCV', _) :- python_import('SimpleCV').

pkg(virtualenv).
detect(virtualenv, _) :- python_import(virtualenv).

pkg(networkx).
detect(networkx, _) :- python_import(networkx).
