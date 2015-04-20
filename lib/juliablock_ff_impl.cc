/* -*- c++ -*- */
/* 
 * Copyright 2015 <+YOU OR YOUR COMPANY+>.
 * 
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3, or (at your option)
 * any later version.
 * 
 * This software is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#include <gnuradio/io_signature.h>
#include "juliablock_ff_impl.h"
#include <string.h>

namespace gr {
  namespace juliaffi {

    juliablock_ff::sptr
    juliablock_ff::make(char* filepath)
    {
      return gnuradio::get_initial_sptr
        (new juliablock_ff_impl(filepath));
    }

    /*
     * The private constructor
     */
    juliablock_ff_impl::juliablock_ff_impl(char *filepath)
      : gr::block("juliablock_ff",
              gr::io_signature::make(1, 1, sizeof(float)),
              gr::io_signature::make(1, 1, sizeof(float)))
    {
        jl_init("/usr/local/bin");
        char *eval_string;
        sprintf(eval_string, "require(\"%s\")", filepath);
        jl_eval_string(eval_string);
        julia_work_function = jl_get_function(jl_main_module, "work");

        if (jl_exception_occurred())
            printf("%s \n", jl_typeof_str(jl_exception_occurred()));
    }

    /*
     * Our virtual destructor.
     */
    juliablock_ff_impl::~juliablock_ff_impl()
    {
    }

    void
    juliablock_ff_impl::forecast (int noutput_items, gr_vector_int &ninput_items_required)
    {
       ninput_items_required[0] = noutput_items;
    }

    int
    juliablock_ff_impl::general_work (int noutput_items,
                       gr_vector_int &ninput_items,
                       gr_vector_const_void_star &input_items,
                       gr_vector_void_star &output_items)
    {
        // const float *in = (const float *) input_items[0];
        // float *out      = (float *)       output_items[0];

        jl_value_t *array_type = jl_apply_array_type(jl_float32_type, 1);
        jl_array_t *x          = jl_ptr_to_array_1d(array_type, (void *) input_items[0], noutput_items, 0); 
        jl_array_t *y          = jl_ptr_to_array_1d(array_type, (void *) output_items[0], noutput_items, 0);
        
        jl_call2(julia_work_function, (jl_value_t*) y, (jl_value_t*) x);

        // Tell runtime system how many input items we consumed on
        // each input stream.
        consume_each (noutput_items);

        // Tell runtime system how many output items we produced.
        return noutput_items;
    }

  } /* namespace juliaffi */
} /* namespace gr */

