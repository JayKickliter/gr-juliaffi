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


#ifndef INCLUDED_JULIAFFI_JULIABLOCK_FF_H
#define INCLUDED_JULIAFFI_JULIABLOCK_FF_H

#include <juliaffi/api.h>
#include <gnuradio/block.h>

namespace gr {
  namespace juliaffi {

    /*!
     * \brief <+description of block+>
     * \ingroup juliaffi
     *
     */
    class JULIAFFI_API juliablock_ff : virtual public gr::block
    {
     public:
      typedef boost::shared_ptr<juliablock_ff> sptr;

      /*!
       * \brief Return a shared_ptr to a new instance of juliaffi::juliablock_ff.
       *
       * To avoid accidental use of raw pointers, juliaffi::juliablock_ff's
       * constructor is in a private implementation
       * class. juliaffi::juliablock_ff::make is the public interface for
       * creating new instances.
       */
      static sptr make(char *filepath);
    };

  } // namespace juliaffi
} // namespace gr

#endif /* INCLUDED_JULIAFFI_JULIABLOCK_FF_H */

