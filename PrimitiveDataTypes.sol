// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Primitives{
    bool public boo = true;

    // 부호 없는 정수
    uint8 public u8 = 1;
    uint256 public u256 = 456;
    uint256 public u = 123;

    // 부호 있는 정수
    int8 public i8 = -1;
    int256 public i256 = -456;
    int256 public i = -123;

    int256 public minInt = type(int256).min; // -2^255
    int256 public maxInt = type(int256).max; // 2^255 - 1

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    // public이 아니기 때문에 버튼이 안생김
    // public : 누구나 호출 가능(외부, 내부 모두)
    // private : 오직 같은 계약 내부에서만 호출 가능(상속받은 계약도 접근 불가)
    // public, private 둘 다 아니면 기본값은 internal
    // internal : 같은 계약과 상속받은 계약 내부에서 호출 가능
    bytes1 a = 0xb5;
    bytes1 b = 0x56;

    bool public defaultBoo; // default : false
    uint256 public defaultUint; // default : 0
    int256 public defaultInt; // default : 0
    address public defaultAddr; // default : 0x0000000000000000000000000000000000000000
}