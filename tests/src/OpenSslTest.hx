package;

import sys.crypto.SHA512;

class OpenSslTest extends haxe.unit.TestCase
{
    public function testSha512()
    {
		var r = SHA512.encode("abc");
		assertEquals("ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f", r);
    }
}
