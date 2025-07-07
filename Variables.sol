// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Variables{
    // 상태 변수 => text,num은 스마트 계약의 영구 상태로 블록체인에 저장됨
    // 이 값은 변경되기 전까지 영구 저장됨
    string public text = "Hello";
    uint256 public num = 123;
    // text, num은 public 상태 변수 -> 자동 getter 함수 생성 -> 버튼 클릭 시 값이 보임

    // doSomething()은 public view 함수지만, 내부에서 값을 지정만 하고, return이나 로그 emit을 안함
    // 그래서 버튼을 눌러도 아무 반응이 없는 것 처럼 보임
    function doSomething() public view{
        // 지역 변수 => i는 doSomething() 함수 안에서만 존재
        // 함수 호출이 끝나면 사라짐
        // 블록체인에 저장되지 않음 -> 가스 비용 없음
        uint256 i = 456;

        // 글로벌 변수 => timestamp, sender
        // Solidity에서는 EVM의 정보를 읽을 수 있는 전역 내장 변수를 제공함
        uint256 timestamp = block.timestamp; // 현재 블록의 타임스탬프(초 단위)
        address sender = msg.sender; // 이 함수를 호출한 지갑 주소
        // 이 값들은 블록체인에서 자동으로 주어짐. -> view 함수니까 상태를 변경하지 않고 읽기만 함
    }

    // 만약 리턴 값을 보고 싶으면
    function doSomethingReturn() public view returns (uint256, uint256, address){
        uint256 return_i = 123;
        uint256 return_timestamp = block.timestamp;
        address return_sender = msg.sender;
        return (return_i, return_timestamp, return_sender);
    }
}
// i와 block.timestamp, msg.sender의 차이는 사용자가 만든 임시값이냐? Solidity가 EVM에서 가져오는 전역 데이터인가?로 나뉨
// 둘 다 함수 내부에서 쓰이지만 출처와 의미가 다르기 때문에 구분
// Solidity에서 가장 비싼 연산ㄴ은 Storage를 읽고 쓰는 것
// Memory는 값은 빠르게 접근 가능하고 비용이 거의 없음
// Stack에 저장되는 값은 거의 공짜 수준
// 지역 변수는 메모리 혹은 스택에 저장 -> 가스 소모 없음
// 상태 변수는 Storage에 저장되며 블록체인에 저장되기 때문에 가스 소모 있음
// 글로벌 변수는 읽기 전용이므로 블록체인에서 값을 읽어오는 데 아주 소량의 가스 필요