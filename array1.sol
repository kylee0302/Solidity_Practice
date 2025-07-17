// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

// Solidty에서 변수의 저장 위치는 크게 3가지 => 배열이나 구조제처럼 커다란 건 어디에 저장할지 직접 지정하고 선언해줘야 함
// Storage : 블록체인에 저장되는 영구 저장
// Memory : 함수 실행 중에만 존재하는 임시 저장소 -> 함수 끝나면 사라짐
// Calldata : 함수 파라미터에만 사용되는 읽기 전용 임시 공간(예 : 외부에서 전달된 매개변수) -> 읽기 전용이므로 휘발성

contract Array{
    uint256[] public arr; // 동적 크기의 배열로 크기를 정하지 않고 push()로 값 추가 가능. public이라 자동 getter가 생기며, arr(0) 형태로 접근 가능
    uint256[] public arr2 = [1,2,3]; // 초기값이 [1,2,3]인 동적 배열
    uint256[10] public myFixedSizeArr; // 정적 배열로, 길이가 항상 10 -> push() 사용할 수 없음

    function get(uint256 i) public view returns (uint256){
        return arr[i]; // arr 배열의 인덱스 i에 해당하는 값을 반환
    }

    function getArr() public view returns(uint256[] memory){
        return arr; // arr 배열 전체를 memory로 반환
    }

    function push(uint256 i) public{
        arr.push(i); // arr에 새로운 값 추가(맨 끝에 삽입)
    }

    function pop() public{
        arr.pop(); // 배열의 마지막 값을 제거(배열 길이 1 줄어듦)
    }

    function getLength() public view returns (uint256){
        return arr.length; // 배열 arr의 현재 길이를 반환
    }

    function remove(uint256 index) public {
        delete arr[index]; // arr[index] 값을 0으로 초기화(delete는 해당 인덱스만 초기화하고 길이는 유지)
        // 배열에서 완전히 제거하려면 수동으로 shift(앞당기기)하거나 새로운 배열을 만들어야 함
    }

    function examples() external pure {
        // uint256[] memory a = new uint256[](5); // 메모리 상의 배열을 생성(초기 크기가 5인 동적 배열을 메모리에 생성하는 것, 동작은 정적배열처럼 작동), 크기를 바꾸거나 push/pop 불가
        // memory에서 선언한 uint[]는 타입은 동적이지만, 실제로는 크기가 고정된 정적 배열처럼 동작함
        uint256[][] memory b = new uint256[][](2); // 2차원 배열 선언(2개의 행)
        // memory 배열은 크기가 고정되어 있기 때문에 push() 불가능
        for(uint256 i = 0; i < b.length; i++){
            b[i] = new uint256[](3); // 각 행에 대해 3개의 열을 할당(총 2*3 배열 구조)
        }
        // 값 지정 -> 인덱스를 이용해서 수동으로 할당해야 함
        b[0][0] = 1;
        b[0][1] = 2;
        b[0][2] = 3;
        b[1][0] = 4;
        b[1][1] = 5;
        b[1][2] = 6;
    }

    function examples_2() external pure returns (uint256[3] memory, uint256[3] memory){ // memory에 저장된 고정 크기 배열(3칸짜리 배열) 두 개를 반환
        uint256[3] memory row1 = [uint256(1),2,3]; // uint256(1), uint256(4)는 명시적 형변환으로 나머지는 추론되므로 굳이 uint256() 하지 않아도 됨
        uint256[3] memory row2 = [uint256(4),5,6]; // Solidity에서 memory 배열을 선언하면서 값을 한 번에 초기화 할 때는 형태가 엄격하게 지정되어야 하므로 배열의 각 요소가 uint256이라는 것을 확실히 명시해야 함
                                                   // 그렇지 않으면 배열의 타입과 정확히 일치하지 않아 타입 불일치 오류가 발생할 수도 있음
        return (row1, row2);
    }
}
// pure vs view 함수 선택 기준
// 상태 변수 사용 X => pure : 단순 연산만 하는 함수 (a + b) 등 (그러나 pure 함수 내에서도 메모리 작업은 허용됨, 상태 변수 예를 들어 arr.push() 이런건 불가)
// 상태 변수 읽기만 함 => view : 저장된 값을 읽기만 할 때 (return num)
// 상태 변수 변경 => 키워드 없음 : 그냥 일반 public 함수로 설정

// public vs external vs interval vs private 선택 기준
// 외부에서도 호출 가능, 내부에서도 사용하고 싶음(가장 유연함) : public
// 외부에서만 호출할 예정(내부에서는 안씀) => 외부 인터페이스용(API용) : external => 내부에서 함수를 직접 호출하려면 this. 형태로 접근해야 함
// 오직 컨트랙트 내부에서만 사용(내부 함수 도우미 등) : internal
// 오직 이 파일 내부에서만 사용(상속도 불가) : private