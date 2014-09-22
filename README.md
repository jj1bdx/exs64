# exs64: xorshift64star PRNG for Erlang

xorshift64star is a 64-bit PRNG of (2^64-1) period.

See <http://xorshift.di.unimi.it/> for the further details.

A preliminary test shows the `exs64` functions takes *less* execution time
than twice of `random` module on a x86\_64 or amd64 architecture environment,
and roughly the same speed as the `exsplus` (xorshift128plus) functions.

## Author

Algorithm by Sebastiano Vigna, made public domain.

Programmed by Kenji Rikitake.

## LICENSE

MIT License.

(The code under `c-example` directory is licensed CC0/public domain.)
