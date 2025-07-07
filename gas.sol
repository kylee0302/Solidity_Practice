// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

// 이더리움에서 트랜잭션 수수료 = gas used * gas price
// gas :             EVM의 작업 단위 (예 : 계산, 저장 등)
// gas spent :       실제로 사용된 gas의 양
// gas price :       gas 하나당 지불할 이더 가격
// ether :           gas * gas price 결과로 지불되는 실제 수수료
// unspent gas :     남은 gas는 환불됨(수수료로 안 나감)
// gas limit :       트랜잭션마다 사용자가 설정하는 최대 gas 한도(너무 낮으면 트랜잭션이 실패할 수 있음)
// block gas limit : 블록 하나에 담을 수 있는 전체 gas 총량(네트워크가 설정) 
// gas price가 높을수록 채굴자가 더 빨리 처리 해줌. 즉, Gas Price는 트랜잭션의 우선순위 결정 요소
// 지금은 단순 gas price가 아니라 Fee = (base fee + priority fee) * gas used 방식으로 바뀌었음
// base fee :        네트워크가 자동 조절
// pritority tip :   내가 더 빨리 처리되길 원하면 추가로 주는 팁
contract Gas{
     uint256 public i = 0;

     function forever() public{ // i += 1을 무한 루프를 돌며 반복하면서 gas가 모두 소모될 때까지 실행되다가, 결국 gas 부족으로 트랜잭션 실패가 발생
        while(true){
            i += 1; // 트랜잭션 실패 시 상태 변수 i는 변경되지 않고 실패 시 롤백 되며 gas에 소모한 값은 환불되지 않고 소모된만큼 사라짐
            // 트랜잭션이 완전히 처리되기 전에 i 값이 변하는 것을 스마트 게약 외부에서 실시간으로 확인하는 것은 불가능
            // 왜냐하면, 트랜잭션이 '성공적으로 채굴'되고 블록에 포함되기 전까지는 상태 변경은 일어나지 않은 것으로 간주되기 때문
        }
     }
}