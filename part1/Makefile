# Makefile for daxpy

# ---- Program settings ----
PROGRAM   := daxpy
SRC       := daxpy.cpp
OBJ       := daxpy.o

CXX       := g++
CXXFLAGS  := -O2
LDFLAGS   := -static

# ---- Default target ----
.PHONY: all
all: $(PROGRAM)

# ---- Compile to object file ----
$(OBJ): $(SRC)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

# ---- Link to executable (static) ----
$(PROGRAM): $(OBJ)
	$(CXX) $(LDFLAGS) -o $@ $^

# ---- Generate assembly with -S -O2 ----
.PHONY: asm
asm: $(PROGRAM).s

$(PROGRAM).s: $(SRC)
	$(CXX) -S -O2 -o $@ $<

# ---- Clean build ----
.PHONY: clean
clean:
	rm -f $(PROGRAM) $(OBJ) $(PROGRAM).s