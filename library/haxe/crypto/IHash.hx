package haxe.crypto;

interface IHash
{
	/**
		Returns the hex string hash value
	**/
	function calculate(msg:String) : String;

	/**
		Returns the length of the hash in bytes
	**/
	function getLengthBytes() : Int;

	/**
		Returns the length of the hash in bits
	**/
	function getLengthBits() : Int;

	/**
		Return the hashing block size in bytes
	**/
	function getBlockSizeBytes() : Int;

	/**
		Return the hashing block size in bits
	**/
	function getBlockSizeBits() : Int;

	/**
		Just to enforce method.
	**/
	function toString() : String;
}