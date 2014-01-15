package sys.crypto;

#if cpp
import cpp.Lib;
#else
import neko.Lib;
#end

class Sha1 implements haxe.crypto.IHash
{
	public function new() {}
	
	public function toString() : String return "sha1";
	public function calculate(msg:String) : String return encode(msg);
	public function getLengthBytes() return 20;
	public function getLengthBits() return 160;
	public function getBlockSizeBytes() return 64;
	public function getBlockSizeBits() return 512;
	
	public static inline function encode(s:String) : String
	{
		#if cpp
		return _sha1(s);
		#elseif neko
		return Lib.nekoToHaxe(_sha1(Lib.haxeToNeko(s)));
		#elseif php
		return untyped __call__("sha1", s);
		#end
	}
	
	static var _sha1 = Lib.load("crypto", "crypto_sha1", 1);
}
