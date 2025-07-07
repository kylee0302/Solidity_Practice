// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract IfElse{
    // pure 함수는 상태 변수나 블록체인 환경 정보를 읽거나 수정하지 않는 함수
    // pure 함수이므로 상태 변수나 블록 정보 등 외부 정보는 사용하지 않고 단순 계산만 수행
    function foo(uint256 x) public pure returns (uint256){
        if (x < 10){
            return 0;
        } else if(x < 20){
            return 1;
        } else{
            return 2;
        }
    }

    function ternary(uint256 _x) public pure returns (uint256){
        // if(_x < 10){
        //    return 1;
        // }
        // return 2;

        // 삼항 연산자 => 조건 ? 참일 때 값 : 거짓일 때 값
        return _x < 10 ? 1 : 2;
    }
}
