/* -*- c++ -*- */

#define JULIAFFI_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "juliaffi_swig_doc.i"

%{
#include "juliaffi/jlblock_ff.h"
#include "juliaffi/juliablock_ff.h"
%}

%include "juliaffi/jlblock_ff.h"
GR_SWIG_BLOCK_MAGIC2(juliaffi, jlblock_ff);
%include "juliaffi/juliablock_ff.h"
GR_SWIG_BLOCK_MAGIC2(juliaffi, juliablock_ff);
