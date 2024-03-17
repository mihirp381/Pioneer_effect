/* Read the dataset */
DATA a1;
INFILE "H:\HW4\pims.csv" DLM = "," FIRSTOBS = 2 MISSOVER;
INPUT ms qual price plb dc pion ef phpf plpf psc papc ncomp mktexp tyrp pnp custtyp ncust custsize penew cap rbvi emprody union;
RUN;

/* Print */
PROC PRINT DATA = a1 (OBS = 10);
RUN;

/* 2SLS */
PROC SYSLIN 2SLS SIMPLE;
ENDOGENOUS ms qual plb price dc;
INSTRUMENTS pion ef phpf plpf psc papc ncomp mktexp tyrp pnp custtyp ncust custsize penew cap rbvi emprody union;
MODEL ms = qual plb price pion ef phpf plpf psc papc ncomp mktexp;
MODEL qual = price dc pion ef tyrp mktexp pnp;
MODEL plb = dc pion tyrp ef pnp custtyp ncust custsize;
MODEL price = ms qual dc pion ef tyrp mktexp pnp;
MODEL dc = ms qual pion ef tyrp penew cap rbvi emprody union;
RUN;

/* OLS */
PROC REG;
MODEL ms = qual plb price pion ef phpf plpf psc papc ncomp mktexp;
RUN;
