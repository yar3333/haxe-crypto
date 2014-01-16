package;

import haxe.crypto.Hmac;
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
	
	public function testHmacSha512_0()
    {
		var r = new Hmac(new Sha512()).calculate("def", "abc");
		assertEquals("17111e70f32d48a37ccc50a21deb12b40dfe223abf5ac852428000182125dab8a12ee95dd9f526bfb79c1a4fe00a4118e3b525f40eb8291325e3030f2e13ad34", r);
    }
	
	public function testHmacSha512_1()
    {
		var r = new Hmac(new Sha512()).calculate("d985b925d6e451c3f5486fa2ff4a6e4dcb58c5ddda4ed7a0d1780df2901a1420", "abc");
		assertEquals("a7f070bc3c52a7568b563b94f779be7b603cfc5a50ed5b3d3b2b0e40f0b540357775dc0814a7887b87b0762c29006e411d507f19c9707ea0ad1615bfbd02f15e", r);
    }
	
	public function testHmacSha512_2()
    {
		var r = new Hmac(new Sha512()).calculate("d985b925d6e451c3f5486fa2ff4a6e4dcb58c5ddda4ed7a0d1780df2901a1420", "method=getInfo&nonce=1389825700");
		assertEquals("7d4b320ee85639b45c8d2d04a081f2bbe67c3030b9d296f5ae4363c5d58b985541f416be220986c8835b43aaca13acc4e7d7f161400a8b20c33d514812b684b1", r);
    }
}
