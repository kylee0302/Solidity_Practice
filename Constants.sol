// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Constants {
    // 상수는 보통 대문자로 이름 짓는 관례
    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc; // 주소 타입 상수
    uint256 public constant MY_UINT = 123; // 정수 타입 상수
    // 상수는 변경 불가능(함수로도 바꿀 수 없음)
    // 애초에 컴파일 시점에 값이 코드에 박혀 있으므로 실행 중에는 값을 계산하거나 저장할 필요가 없음
    // Storage를 쓰지 않음 -> 가스 절약 효과 큼
}