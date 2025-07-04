// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Counter{ // Counter라는 이름의 스마트 계약 선언
    uint256 public count; // count는 uint256 타입의 상태 변수
    // public 키워드를 쓰면 자동으로 count()라는 getter 함수가 생김 -> 외부에서 count() 호출 시 값을 확인 가능
    // 만약 public이 아닌 private을 쓰면 count 버튼은 없어지고 get 버튼만 남을 것

    function get() public view returns (uint256){ // count 값을 반환하는 함수(사실 public을 명시했으므로 사용하지 않아도 됨)
        return count;
    }

    function inc() public{ // count 값을 1 증가
        count += 1;
    }

    function dec() public{ // count 값을 1 감소
        count -= 1;
    }
    // 이 함수들은 public이기 때문에 외부에서 호출 가능
}