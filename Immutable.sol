// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

// Immutable은 배포 시 딱 한 번만 값 설정 가능한 불변 변수
contract Immutable{
    address public immutable myAddr; // 이 계약을 배포한 사람의 지갑 주소(msg.sender)
    uint256 public immutable myUint; // 생성자(constructor)로 입력받은 숫자

    constructor(uint256 _myUint){ // constructor란 스마트 계약이 배포될 때 한 번만 실행되고, 그 이후에는 절대로 호출할 수 없는 함수
        // constructor는 public, external 같은 명시 필요 없음(사용 불가)
        myAddr = msg.sender;
        myUint = _myUint;
    }
}
// Deploy 클릭 전, 입력 칸에 입력 값 입력 -> Deploy 버튼 클릭 -> msg.sender = 지금 지갑 주소 -> myAddr, myUint 둘 다 딱 한번만 저장됨
// 생성된 myAddr() 버튼 클릭 -> 내 지갑 주소 확인 가능, myUint() 버튼 클릭 -> 입력값 출력 확인 가능
// constant는 컴파일 시 고정이었다면 immutable은 배포(constructor) 시 고정
// 만약 한 번 배포한 뒤 다른 값을 넣어서 재배포 하면 값이 바뀌는 것이 아닌 새로운 계약이 생긴 것