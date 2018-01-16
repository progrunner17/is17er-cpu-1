#!/bin/sh
make
cd ../../min-caml
make min-caml
./min-caml raytracer/min-rt -globals raytracer/globals
cd ../sim/sim_core
./simulator -s ../../min-caml/raytracer/min-rt.s -i ../../min-caml/raytracer/sld/contest.sld -o contest.ppm

