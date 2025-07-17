// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract ArrayRemoveByShifting {
    // [1,2,3] -- remove(1) --> [1,3,3] --> [1,3]
    // [1,2,3,4,5,6] -- remove(2) --> [1,2,4,5,6,6] --> [1,2,4,5,6]
    // [1,2,3,4,5,6] -- remove(0) --> [2,3,4,5,6,6] --> [2,3,4,5,6]
    // [1] -- remove(0) --> [1] --> []

    uint256[] public arr;

    function remove(uint256 _index) public {
        require(_index < arr.length, "index out of bounds");
        // require는 외부 입력값이나 함수 호출 전에 유효성 검사를 위해 사용
        // 실패 시 에러 메시지와 함께 트랜잭션 revert(실행 취소), 사용된 만큼 제외하고 가스 반환됨
        
        for(uint256 i = _index; i < arr.length - 1; i++){
            arr[i] = arr[i+1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1,2,3,4,5];
        remove(2);
        // [1,2,4,5]
        // assert는 절대 실패하면 안 되는 내부 로직 검사로 실패 시 트랜잭션 revert(실행 취소), 가스 다 소모 + assertion failed 에러 발생하며 에러 메시지는 없음
        // assert는 코드 로직이 우리가 기대한 대로 동작하는지 확인하는 용도
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        // []
        assert(arr.length == 0);
    }
}