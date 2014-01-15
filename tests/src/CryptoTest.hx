package;

import sys.crypto.Md5;
import sys.crypto.Sha1;
import sys.crypto.Ripemd160;
import sys.crypto.Sha256;
import sys.crypto.Sha512;

class CryptoTest extends haxe.unit.TestCase
{
    public function testMd5()
    {
		var r = Md5.encode("abc");
		assertEquals("900150983cd24fb0d6963f7d28e17f72", r);
    }
    
	public function testSha1()
    {
		var r = Sha1.encode("abc");
		assertEquals("a9993e364706816aba3e25717850c26c9cd0d89d", r);
    }
	
	public function testRipemd160()
    {
		var r = Ripemd160.encode("abc");
		assertEquals("8eb208f7e05d987a9b044a8e98c6b087f15a0bfc", r);
    }
	
    public function testSha256_sys()
    {
		var r = Sha256.encode("abc");
		assertEquals("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", r);
    }
	
    public function testSha256_haxe()
    {
		var r = haxe.crypto.Sha256.encode("abc");
		assertEquals("ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad", r);
    }
    
	public function testSha512()
    {
		var r = Sha512.encode("abc");
		assertEquals("ddaf35a193617abacc417349ae20413112e6fa4e89a97ea20a9eeee64b55d39a2192992a274fc1a836ba3c23a3feebbd454d4423643ce80e2a9ac94fa54ca49f", r);
    }
}
