/* -*- c++ -*- */

#define JULIAFFI_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "juliaffi_swig_doc.i"

%{
#include "juliaffi/juliablock_ff.h"
%}

%include "juliaffi/juliablock_ff.h"
GR_SWIG_BLOCK_MAGIC2(juliaffi, juliablock_ff);
