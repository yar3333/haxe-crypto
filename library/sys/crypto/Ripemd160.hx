package sys.crypto;

#if cpp
import cpp.Lib;
#else
import neko.Lib;
#end

class Ripemd160
{
	public function new() {}
	
	public function toString() : String return "ripemd160";
	public function calculate(msg:String) : String return encode(msg);
	public function getLengthBytes() return 20;
	public function getLengthBits() return 160;
	public function getBlockSizeBytes() return 64;
	public function getBlockSizeBits() return 512;
	
	public static inline function encode(s:String) : String
	{
		#if cpp
		return _ripemd160(s);
		#elseif neko
		return Lib.nekoToHaxe(_ripemd160(Lib.haxeToNeko(s)));
		#end
	}
	
	static var _ripemd160 = Lib.load("crypto", "crypto_ripemd160", 1);
}
