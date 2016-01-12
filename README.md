# exs64: xorshift64star PRNG for Erlang

Note 12-JAN-2016: this algorithm is no longer listed as a part of Xorshift\*/+
webpage. See
<https://web.archive.org/web/20150905215225/http://xorshift.di.unimi.it/> for
the old archive.  No further development will be made. Use `exsplus` or the
rand module in OTP 18 and later.

xorshift64star is a 64-bit PRNG of (2^64-1) period.

See <http://xorshift.di.unimi.it/> for the further details.


## LICENSE

MIT License.

(The code under `c-example` directory is licensed CC0/public domain.)

# Tested platforms

* FreeBSD/amd64 10.1-STABLE with Erlang/OTP 17.4 and HiPE
* OS X x86\_64 10.10.1 with Erlang/OTP 17.4 and HiPE

* HiPE is not a requirement but recommended to be enabled.

A preliminary test shows the `exs64` functions takes *less* execution time
than twice of `random` module on a x86\_64 or amd64 architecture environment,
and roughly the same speed as the `exsplus` (xorshift128plus) functions.

## Make options (of erlang.mk)

* `Makefile` works on both BSD/GNU make
* `Makefile.[module_name]` is the real GNU make file; edit this file for modification
* Building: `make`
* Documentation: `make docs`
* Testing: `make tests`
* Execution speed benchmark: `make speed`
* See also [erlang.mk](https://github.com/extend/erlang.mk) for the details

## TODO

* More seeding algorithms
* More evaluation and refactoring

## Authors

Algorithm by Sebastiano Vigna, and he made it public domain.

Programmed by Kenji Rikitake.

## Contributors

Dan Gudmundsson
