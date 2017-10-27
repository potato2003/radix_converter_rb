require "test/unit"
include Test::Unit::Assertions
require "radix_converter"

# convert from radix 10 to radix 10
c10to10 = RadixConverter.new(from: 10, to: 10)
assert c10to10.convert(1)     == 1
assert c10to10.convert(10)    == 10
assert c10to10.convert(100)   == 100
assert c10to10.convert("100") == 100


# convert from radix 2 to radix 10
c2to10 = RadixConverter.new(from: 2, to: 10)
assert c2to10.convert("1")    == 0b0001
assert c2to10.convert("10")   == 0b0010
assert c2to10.convert("11")   == 0b0011
assert c2to10.convert("100")  == 0b0100
assert c2to10.convert("10"+"0001") == 0b10_0001


# convert from radix 8 to radix 10
c8to10 = RadixConverter.new(from: 8, to: 10)
assert c8to10.convert("1")   == 01
assert c8to10.convert("7")   == 07
assert c8to10.convert("10")  == 010
assert c8to10.convert("77")  == 077
assert c8to10.convert("777") == 0777
assert c8to10.convert("700"+"0000") == 0700_0000


# convert from radix 16 to radix 10
c16to10 = RadixConverter.new(from: 16, to: 10)
assert c16to10.convert("1")    == 0x0001
assert c16to10.convert("A")    == 0x000A
assert c16to10.convert("10")   == 0x0010
assert c16to10.convert("FF")   == 0x00FF
assert c16to10.convert("FFFF") == 0xFFFF
assert c16to10.convert("F000"+"0000") == 0xF000_0000


# convert from radix 36 to radix 10
c36to10 = RadixConverter.new(from: 36, to: 10)
assert c36to10.convert("0")    == 0
assert c36to10.convert("9")    == 9
assert c36to10.convert("G")    == 16
assert c36to10.convert("H")    == 17
assert c36to10.convert("W")    == 32
assert c36to10.convert("X")    == 33
assert c36to10.convert("Y")    == 34
assert c36to10.convert("Z")    == 35
assert c36to10.convert("10")   ==  1 * 36
assert c36to10.convert("Z0")   == 35 * 36
assert c36to10.convert("Z00")  == 35 * (36 ** 2)
assert c36to10.convert("Z01")  == 35 * (36 ** 2) + 1


# 
# use other symbols
#

alpha26to10 = RadixConverter.new(from: [*'A'..'Z'], to: 10)
assert alpha26to10.convert("A") == 0
assert alpha26to10.convert("B") == 1
assert alpha26to10.convert("Z") == 25

