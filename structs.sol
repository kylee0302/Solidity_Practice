// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Todos {
    // 구조체 선언
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos; // Todo 구조체들의 배열, public으로 선언되어 있어 todos(0), todos(1)처럼 외부에서 단건 조회 가능

    function create(string calldata _text) public { // 각기 다른 세 가지 방식으로 todos 배열에 항목을 넣음
        todos.push(Todo(_text, false)); // 위치 기반 초기화 -> 생성자처럼 인자를 순서대로 넣음(text, completed 순)

        todos.push(Todo({text: _text, completed: false})); // 명시적 초기화 -> 필드명을 직접 써서 값 지정(순서 상관없음)

        // 나중에 개별 속성 할당 후 push
        Todo memory todo; // 먼저 Todo 타입의 임시 객체 생성 후 필드값 대입
        todo.text = _text; // completed는 기본값인 false 유지됨
        todos.push(todo);
    }

    function get(uint256 _index) public view returns (string memory text, bool completed) { // index를 받아 해당 Todo의 text, completed 값을 반환
        Todo storage todo = todos[_index]; // storage를 사용함으로써 실제 컨트랙트 내 상태에 접근
        return (todo.text, todo.completed); // 구조체의 값을 분해해서 반환
    }

    function updateText(uint256 _index, string calldata _text) public { // 특정 인덱스의 text 값을 수정하는 함수로 구조체의 참조(storage)를 통해 배열을 직접 수정
        Todo storage todo = todos[_index]; // todos[_index]를 직접 수정하기 때문에 storage 사용, _text는 외부에서 전달받는 읽기 전용 문자열 -> calldata
        todo.text = _text;
    }

    function toggleCompleted(uint256 _index) public { // 완료 여부를 true <-> false로 토글
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed; // 기존 값의 반대값으로 토글
    }

    function getLength() public view returns (uint256) {
        return todos.length;
    }
}