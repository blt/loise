################################
Loise: A Noise-Generator for LFE
################################

.. image:: images/loise.jpg

Introduction
============

This is a library, written in `LFE`_, useful for generating Perlin and Simplex
noise. Perlin noise is a computer-generated visual effect developed by Ken
Perlin, who won an Academy Award for Technical Achievement for inventing it.
It can be used to simulate elements from nature, and is especially useful in
circumstances where computer memory is limited. (See the complete `Perlin
Wikipedia article`_.)

Simplex noise, on the other hand, is a method for constructing an n-dimensional
noise function comparable to Perlin noise ("classic" noise) but with a lower
computational overhead, especially in larger dimensions. Ken Perlin designe
the algorithm in 2001 to address the limitations of his classic noise
function, especially in higher dimensions. (See the complete `Simplex Wikipedia
article `_ for more.)

Background
----------

This is a port of the `Racket noise-generator`_ by `jpverkamp`_ to `LFE`_.

Dependencies
------------

This project assumes that you have `rebar`_ installed somwhere in your
``$PATH``.

This project depends upon the following, which installed to the ``deps``
directory of this project when you run ``make deps``:

* `LFE`_ (Lisp Flavored Erlang; needed only to compile)
* `lfeunit`_ (needed only to run the unit tests)


Using Loise
===========

The first place to start is ensuring that the code you obtained works as
epxected. To find out, run the unit tests:

..code:: bash

    $ cd loise
    $ make check

Once everything is working, start up an LFE REPL:

..code:: bash

    $ make shell

You can now use loise by itself, if you so desire. Here is some example usage:

.. code:: lisp

    > (: loise perlin 3.14 1.59 2.65)
    -0.3772216257243449


.. Links
.. -----
.. _Racket noise-generator: https://github.com/jpverkamp/noise
.. _Perlin Wikipedia artic: http://en.wikipedia.org/wiki/Perlin_noise
.. _Simplex Wikipedia artic: http://en.wikipedia.org/wiki/Simplex_noise
.. _jpverkamp: https://github.com/jpverkamp
.. _LFE: http://lfe.github.io/
.. _rebar: https://github.com/rebar/rebar
.. _lfeunit: https://github.com/lfe/lfeunit