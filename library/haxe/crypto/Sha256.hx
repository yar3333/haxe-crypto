package haxe.crypto;

class Sha256 implements haxe.crypto.IHash
{
	public function new() {}
	
	public function toString() : String return "sha256";
	public function calculate(msg:String) : String return encode(msg);
	public function getLengthBytes() return 32;
	public function getLengthBits() return 256;
	public function getBlockSizeBytes() return 64;
	public function getBlockSizeBits() return 512;

	public static var charSize = 8;
	
	public static function encode(s:String)
	{
		return binb2hex(core_sha256(str2binb(s, 8), s.length * charSize));
	}

	static function S(X, n) { if (X == null) X = 0; return ( X >>> n ) | (X << (32 - n)); }
	static function R(X, n) { if (X == null) X = 0; return ( X >>> n ); }
	static function Ch(x, y, z) return ((x & y) ^ ((~x) & z));
	static function Maj(x, y, z) return ((x & y) ^ (x & z) ^ (y & z));
	static function Sigma0256(x) return (S(x, 2) ^ S(x, 13) ^ S(x, 22));
	static function Sigma1256(x) return (S(x, 6) ^ S(x, 11) ^ S(x, 25));
	static function Gamma0256(x) return (S(x, 7) ^ S(x, 18) ^ R(x, 3));
	static function Gamma1256(x) return (S(x, 17) ^ S(x, 19) ^ R(x, 10));
	
	static function core_sha256 (m:Array<Int>, l)
	{
		var K : Array<Int> = 
		[
			0x428A2F98, 0x71374491, 0xB5C0FBCF, 0xE9B5DBA5, 0x3956C25B, 0x59F111F1, 0x923F82A4, 0xAB1C5ED5,
			0xD807AA98, 0x12835B01, 0x243185BE, 0x550C7DC3, 0x72BE5D74, 0x80DEB1FE, 0x9BDC06A7, 0xC19BF174,
			0xE49B69C1, 0xEFBE4786, 0x0FC19DC6, 0x240CA1CC, 0x2DE92C6F, 0x4A7484AA, 0x5CB0A9DC, 0x76F988DA,
			0x983E5152, 0xA831C66D, 0xB00327C8, 0xBF597FC7, 0xC6E00BF3, 0xD5A79147, 0x06CA6351, 0x14292967,
			0x27B70A85, 0x2E1B2138, 0x4D2C6DFC, 0x53380D13, 0x650A7354, 0x766A0ABB, 0x81C2C92E, 0x92722C85,
			0xA2BFE8A1, 0xA81A664B, 0xC24B8B70, 0xC76C51A3, 0xD192E819, 0xD6990624, 0xF40E3585, 0x106AA070,
			0x19A4C116, 0x1E376C08, 0x2748774C, 0x34B0BCB5, 0x391C0CB3, 0x4ED8AA4A, 0x5B9CCA4F, 0x682E6FF3,
			0x748F82EE, 0x78A5636F, 0x84C87814, 0x8CC70208, 0x90BEFFFA, 0xA4506CEB, 0xBEF9A3F7, 0xC67178F2
		];
		
		var HASH : Array<Int> =
		[
			0x6A09E667, 0xBB67AE85, 0x3C6EF372, 0xA54FF53A, 0x510E527F, 0x9B05688C, 0x1F83D9AB, 0x5BE0CD19
		];

		var W = []; for (i in 0...64) W.push(0);
		W[64] = 0;
		
		var a:Int,b:Int,c:Int,d:Int,e:Int,f:Int,g:Int,h:Int;
		var T1, T2;
		/* append padding */
		if (l >> 5 >= m.length) m[l >> 5] = 0;
		m[l >> 5] |= 0x80 << (24 - l % 32);
		m[((l + 64 >> 9) << 4) + 15] = l;
		var i : Int = 0;
		while ( i < m.length )
		{
			a = HASH[0]; b = HASH[1]; c = HASH[2]; d = HASH[3]; e = HASH[4]; f = HASH[5]; g = HASH[6]; h = HASH[7];
			for ( j in 0...64 )
			{
				if (j < 16) W[j] = m[j + i];
				else		W[j] = cast safeAdd(safeAdd(safeAdd(cast Gamma1256(W[j - 2]), cast W[j - 7]), cast  Gamma0256(W[j - 15])), cast W[j - 16]);
				T1 = safeAdd(safeAdd(safeAdd(safeAdd(cast h, cast Sigma1256(e)), cast Ch(e, f, g)), cast K[j]), cast W[j]);
				T2 = safeAdd(cast Sigma0256(a), cast Maj(a, b, c));
				h = g; g = f; f = e; e = cast safeAdd(cast d, T1); d = c; c = b; b = a; a = cast safeAdd(T1, T2);
			}
			HASH[0] = cast safeAdd(cast a, HASH[0]);
			HASH[1] = cast safeAdd(cast b, HASH[1]);
			HASH[2] = cast safeAdd(cast c, HASH[2]);
			HASH[3] = cast safeAdd(cast d, HASH[3]);
			HASH[4] = cast safeAdd(cast e, HASH[4]);
			HASH[5] = cast safeAdd(cast f, HASH[5]);
			HASH[6] = cast safeAdd(cast g, HASH[6]);
			HASH[7] = cast safeAdd(cast h, HASH[7]);
			i += 16;
		}
		return HASH;
	}
	
	static function safeAdd(x:Int, y:Int)
	{
		if (x == null) x = 0;
		if (y == null) y = 0;
		
		var lsw = (x & 0xFFFF) + (y & 0xFFFF);
		var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
		return (msw << 16) | (lsw & 0xFFFF);
	}
	
	static function binb2hex(bin:Array<Int>) : String
	{
  		var hex_tab = "0123456789abcdef";
		var sb = new StringBuf();
		for (i in 0...(bin.length * 4))
		{
			sb.add(hex_tab.charAt((bin[i >> 2] >> ((3 - i % 4) * 8 + 4)) & 0xF));
			sb.add(hex_tab.charAt((bin[i >> 2] >> ((3 - i % 4) * 8    )) & 0xF));
  		}
  		return sb.toString();
	}
	
	/**
		String to big endian binary
		charSize must be 8 or 16 (Unicode)
	**/
	public static function str2binb(str:String, ?charSize:Int) : Array<Int>
	{
		if (charSize == null) charSize = 8;
		if (charSize != 8 && charSize != 16) throw "Invalid character size";
		var bin = new Array();
		var mask = (1 << charSize) - 1;
		var i = 0;
		var max = str.length * charSize;
		while (i < max)
		{
			if ((i >> 5) >= bin.length) bin[i >> 5] = 0;
			bin[i >> 5] |= (str.charCodeAt(Std.int(i / charSize)) & mask) << (24 - i % 32);
			i += charSize;
		}
		return bin;
	}	
}
