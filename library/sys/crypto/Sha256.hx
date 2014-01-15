package sys.crypto;

#if cpp
import cpp.Lib;
#else
import neko.Lib;
#end

class Sha256 implements haxe.crypto.IHash
{
	public function new() {}
	
	public function toString() : String return "sha256";
	public function calculate(msg:String) : String return encode(msg);
	public function getLengthBytes() return 32;
	public function getLengthBits() return 256;
	public function getBlockSizeBytes() return 64;
	public function getBlockSizeBits() return 512;
	
	public static inline function encode(s:String) : String
	{
		#if cpp
		return _sha256(s);
		#elseif neko
		return Lib.nekoToHaxe(_sha256(Lib.haxeToNeko(s)));
		#end
	}
	
	static var _sha256 = Lib.load("crypto", "crypto_sha256", 1 );
}
