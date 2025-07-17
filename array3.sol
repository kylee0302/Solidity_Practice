// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract ArrayReplaceFromEnd {
    uint256[] public arr;
    function remove(uint256 index) public {
        arr[index] = arr[arr.length - 1];
        arr.pop();
        // 이 function은 마지막 요소를 해당 위치(index)에 복사하고 배열의 마지막 요소를 제거(pop())
        // 함으로써 중간 요소를 제거하는데 드는 shift 비용을 줄이는 방식
        // 중간 요소들을 전부 shift할 필요가 없는 대신 배열의 순서가 유지되지 않기 때문에 순서가 중요한 로직에서는 사용 불가
    }

    function test() public{
        arr = [1,2,3,4];

        remove(1); // [1,4,3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2); // [1,4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}