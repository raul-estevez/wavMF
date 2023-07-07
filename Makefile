.SUFFIXES:

LOUT = /usr/local/lib/
MOUT = /usr/local/include/

FC = gfortran
FCFLAGS = -Wall

SDIR = src
_SRC = wavmf.f90
SRC = $(patsubst %,$(SDIR)/%,$(_SRC))

ODIR = obj
_OBJ= $(subst .f90,.o,$(_SRC))
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

MDIR = mod

$(OBJ): $(SRC)
	mkdir -p obj/ mod/
	$(FC) $(FCFLAGS) -c -o $@ -J $(MDIR) $+

install: $(OBJ)
	ar -r libwavmf.a $(OBJ)
	cp libwavmf.a $(LOUT)
	cp mod/* $(MOUT)
	
uninstall:
	rm -f $(LOUT)libwavmf.a
	rm -f $(MOUT)wavmf.mod
.PHONY: clean
clean:
	rm -rf obj/ mod/ libwavmf.a
