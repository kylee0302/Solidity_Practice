// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract SimpleStorage{
    uint public num; // 이 변수는 블록체인에 저장되는 데이터로, 트랜잭션 없이 조회 가능(가스 없음)

    // set 함수는 외부에서 값을 입력해서 num에 저장하는 함수이며 public이므로 누구나 호출 가능
    // 상태 변수(num)를 변경하기 때문에 트래잭션이 필요하고 가스가 발생
    function set(uint256 _num) public { // set 함수 파라미터 설정할 때 여러 개를 설정한다면, 입력 순서대로 정확히 전달해야 함 => 실무에서는 여러 값 설정시 구조체를 써서 정리하는 경우 많음
        num = _num;
        // 만약 set 함수에 return을 추가해준다면 버튼이 추가로 생기는 것이 아닌 콘솔에서 확인 또는 디버깅용으로 가능 (버튼의 갯수는 return의 개수가 아닌 함수의 개수)
        // Solidity에서는 set()함수처럼 상태를 변경하는 함수는 "트랜잭션"이 발생
        // 트랜잭션이 실행되면, Solidity에서는 결과값을 화면에 직접 반환하는 개념이 없음(블록체인 상태를 바꾼다는 것이 중요하지, 결과를 즉시 받는 건 중요하지 않기 때문)
    }

    function get() public view returns (uint256){ // view이므로 블록체인 데이터를 읽기만 하고, 변경하지 않음
        // get 함수는 상태를 변화시키지 않고 읽기만 하기 때문에, 트랜잭션 없이 호출 가능해서 가스가 들지 않음
        return num;
    }
}