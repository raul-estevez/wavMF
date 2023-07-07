.SUFFIXES:
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

.PHONY: clean
clean:
	sudo rm -r obj/ mod/
