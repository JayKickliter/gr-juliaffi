#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# Copyright 2015 <+YOU OR YOUR COMPANY+>.
#
# This is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# This software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this software; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
#

import os
from gnuradio import gr, gr_unittest
from gnuradio import blocks

# If this gnuradio module has been installed,
#   uncomment the following line to test from the installed location
# from juliaffi import juliaffi_swig as juliaffi
#   else uncomment this following line so that 'make test' can run
import juliaffi_swig as juliaffi

class qa_juliablock_ff (gr_unittest.TestCase):

    def setUp (self):
        self.tb = gr.top_block ()

    def tearDown (self):
        self.tb = None

    def test_001_t (self):
        print 'Testing negate'
        src_data        = (-3, 4, -5.5, 2, 3)
        expected_result = (3, -4, 5.5, -2, -3)
        src             = blocks.vector_source_f(src_data)
        julia_source    = os.path.realpath(os.path.join(os.path.dirname(__file__), '../examples/negate.jl'))
        sqr             = juliaffi.juliablock_ff(julia_source)
        dst             = blocks.vector_sink_f()
        self.tb.connect(src, sqr)
        self.tb.connect(sqr, dst)
        self.tb.run()
        result_data = dst.data()
        print result_data
        self.assertFloatTuplesAlmostEqual(expected_result, result_data, 6)

    def test_002_t (self):
        print 'Testing double negate'
        src_data        = (-3, 4, -5.5, 2, 3)
        expected_result = (-3, 4, -5.5, 2, 3)
        src             = blocks.vector_source_f(src_data)
        julia_source    = os.path.realpath(os.path.join(os.path.dirname(__file__), '../examples/negate.jl'))
        first_negate    = juliaffi.juliablock_ff(julia_source)
        second_negate   = juliaffi.juliablock_ff(julia_source)
        dst             = blocks.vector_sink_f()
        self.tb.connect(src, first_negate)
        self.tb.connect(first_negate, second_negate)
        self.tb.connect(second_negate, dst)
        self.tb.run()
        result_data = dst.data()
        print result_data
        self.assertFloatTuplesAlmostEqual(expected_result, result_data, 6)


if __name__ == '__main__':
    gr_unittest.run(qa_juliablock_ff, "qa_juliablock_ff.xml")
