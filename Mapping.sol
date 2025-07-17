// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Mapping{
    // address를 키로 하고 uint256 값을 저장하는 해시맵
    // 즉, 지갑 주소마다 하나의 숫자 값을 대응시킴
    // public으로 선언되어 있기 때문에 자동으로 getter 함수가 생김
    mapping(address => uint256) public myMap;

    function get(address _addr) public view returns (uint256){ // _addr 주소에 매핑된 값을 반환(public이므로 없어도 됨)
        return myMap[_addr];
    }

    function set(address _addr, uint256 _i) public { // _addr 주소에 _i 값을 매핑
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {// 매핑된 값을 삭제 -> 삭제하면 기본값인 0으로 돌아감
        delete myMap[_addr];
    }
}

contract NestedMapping{
    // 주소를 키로 하고, 그 주소에 대해 다시 uint256 -> bool의 매핑이 있는 구조
    // 즉, "주소-숫자" 조합마다 true 또는 false 값을 저장 가능
    // Solidity에서 mapping은 기본적으로 "존재하지 않는 키에 접근하면 기본 값을 반환" => 따라서 외부에서 어떤 (주소, 숫자) 쌍으로 값을 조회하더라도, 한 번도 set() 함수로 값을 true로 바꾸지 않았다면 항상 false가 반환됨.
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr1, uint256 _i) public view returns (bool) { // 주소 _addr1와 인덱스 _i 조합에 해당하는 bool 값을 반환
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint256 _i, bool _boo) public{ // 특정 주소와 인덱스 조합에 값을 설정
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint256 _i) public { // 해당 조합을 삭제하고 기본값 false로 되돌림
        delete nested[_addr1][_i]; 
    }
}
// 실저에서 어떻게 사용?
// mapping(address => uint256) : 사용자별 보유 토큰 수
// mapping(address => bool) : 화이트리스트
// mapping(address => mapping(uint => bool)) : 유저가 특정 단계에서 권한을 가지고 있는지
// 중요한 점은 같은 주소라도 다른 스마트 컨트랙트에서는 완전히 별개의 저장 공간을 갖기 때문에 서로 전혀 영향을 주지 않음