//Nested Arrays in solidity
contract NestedArrays {

    uint[][] private nested;

    function getArray() public {
        nested.push([1,2,3]);
    }

    // [1, 3, 2, 4]
    function toBytes(uint[] _array)
        public
        returns (bytes _ptr) {
        assembly {
            let len := mload(_array)
            _ptr := msize()
            
            // Bytes
            mstore(_ptr, mul(add(len, 2), 0x20))
            
            // Array 
            mstore(add(_ptr, 0x20), 0x20)
            mstore(add(_ptr, 0x40), len)
            
            let idx := 0
            loop:
            jumpi(end, eq(len, idx))
            mstore(add(_ptr, add(mul(idx,0x20),0x60)), mload(add(_array, add(0x20, mul(idx, 0x20)))))
            idx := add(idx, 1)
            jump(loop)
            
            end:
            // Without return statements memory is overridden
            mstore(0x40, add(mul(len, 0x20), 0x20))
        }
    }
    
    // ["0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x20","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x04","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x01","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x03","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x02","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x04"]
    function toArray(bytes _bytes)
        public
        returns (uint[] _ptr) {
        assembly {
            
            // First 32 bytes are byte array properties
            // Next 32 bytes are the data size of the array elements
            let len := mload(add(_bytes, 0x40))
            _ptr := msize()
            
            // Array
            mstore(_ptr, len)
            
            let idx := 0
            loop:
            jumpi(end, eq(len, idx))
            mstore(add(_ptr, add(mul(idx,0x20),0x20)), mload(add(_bytes, add(0x60, mul(idx, 0x20)))))
            idx := add(idx, 1)
            jump(loop)
            
            end:
            mstore(0x40, add(_ptr,add(mul(len, 0x20), 0x40)))
        }
    }
  
}