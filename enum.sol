// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Enum {
    enum Status {
        Pending, // 0
        Shipped, // 1
        Accepted, // 2
        Rejected, // 3
        Canceled // 4
    }

    Status public status; // status는 Enum.Status 타입의 상태 변수
    // 기본값은 첫 번째 값인 Status.Pending(즉, 0)
    // public이기 때문에 자동으로 getter 함수도 생김

    function get() public view returns (Status){
        return status; // 현재 상태 값을 반환(status가 0이라면 Pending, 1이면 Shipped 등으로 매핑됨)
    }

    function set(Status _status) public {
        status = _status; // 열거형 Status의 값 중 하나를 외부에서 전달받아 status를 변경 가능
        // Solidity에서 enum을 문자열로 직접 입력할 수 없음 -> 숫자로 직접 입력해야 함
    }

    function cancel() public {
        status = Status.Canceled; // 상태를 직접 Canceled로 변경
    }

    function reset() public {
        delete status; // delete는 열거형 변수도 초기화하며, 기본값인 Status.Pending (0)으로 돌아감
    }
}