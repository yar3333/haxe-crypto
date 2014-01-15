package sys.crypto;

#if cpp
import cpp.Lib;
#else
import neko.Lib;
#end

class Md5 implements haxe.crypto.IHash
{
	public function new() {}
	
	public function toString() : String return "md5";
	public function calculate(msg:String) : String return encode(msg);
	public function getLengthBytes() return 16;
	public function getLengthBits() return 128;
	public function getBlockSizeBytes() return 64;
	public function getBlockSizeBits() return 512;
	
	public static inline function encode(s:String) : String
	{
		#if cpp
		return _md5(s);
		#elseif neko
		return Lib.nekoToHaxe(_md5(Lib.haxeToNeko(s)));
		#elseif php
		return untyped __call__("md5", s);
		#end
	}
	
	static var _md5 = Lib.load("crypto", "crypto_md5", 1);
}
