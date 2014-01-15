package sys.crypto;

#if cpp
import cpp.Lib;
#else
import neko.Lib;
#end

class Sha512 implements haxe.crypto.IHash
{
	public function new() {}
	
	public function toString() : String return "sha512";
	public function calculate(msg:String) : String return encode(msg);
	public function getLengthBytes() return 64;
	public function getLengthBits() return 512;
	public function getBlockSizeBytes() return 128;
	public function getBlockSizeBits() return 1024;
	
	public static inline function encode(s:String) : String
	{
		#if cpp
		return _sha512(s);
		#elseif neko
		return Lib.nekoToHaxe(_sha512(Lib.haxeToNeko(s)));
		#end
	}
	
	static var _sha512 = Lib.load("crypto", "crypto_sha512", 1);
}
