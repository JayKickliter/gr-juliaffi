/* -*- c++ -*- */

#define JULIAFFI_API

%include "gnuradio.i"			// the common stuff

//load generated python docstrings
%include "juliaffi_swig_doc.i"

%{
#include "juliaffi/jlblock.h"
%}


%include "juliaffi/jlblock.h"
GR_SWIG_BLOCK_MAGIC2(juliaffi, jlblock);
