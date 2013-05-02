%
%  r.pl
%  marelle-deps
%
%  The R statistical language.
%

:- multifile r_pkg/1.

r_cran_mirror('http://cran.ms.unimelb.edu.au/').

pkg(r).
met(r, _) :- which('R').
installs_with_apt(r, 'r-base').
installs_with_brew(r, 'R').

pkg('R for statistics').
met('R for statistics', _).
depends('R for statistics', _, [
  caret,
  reshape,
  randomForest,
  'RColorBrewer',
  boot,
  tree,
  e1071,
  medley
]).

r_pkg(caret).
r_pkg(reshape).
r_pkg(randomForest).
r_pkg('RColorBrewer').
r_pkg(boot).
r_pkg(tree).
r_pkg(e1071).
r_pkg(medley).

pkg(P) :- r_pkg(P).

met(P, _) :-
    r_pkg(P), !,
    join(['Rscript -e \'library("', P, '")\' >/dev/null 2>/dev/null'], Cmd),
    shell(Cmd).

meet(P, _) :-
    r_pkg(P), !,
    r_cran_mirror(M),
    ( access_file('/usr/local/lib', write) ->
        Sudo = ''
    ;
        Sudo = sudo
    ),
    join([Sudo, 'Rscript -e \'install.packages("', P, '", repos="', M, '")\''], Cmd),
    shell(Cmd).

depends(P, _, [r]) :- r_pkg(P).
