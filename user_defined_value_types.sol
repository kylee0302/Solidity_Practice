// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

// User-Defined Value Types(UDVT) : 기존 타입에 새로운 이름을 붙여서 안전하게 쓰는 방법 => 이걸 사용하면 의미가 명확해지고, 타입 안정성을 확보 가능(새로운 타입을 만든 것과 같음)
// 같은 uint64라도 의미가 다른 걸 구분해서 실수를 방지하기 위해(시간 간격인 Duration이랑 현재 시각인 Timestamp는 둘 다 uint64지만 섞어 쓰면 안됨)
// 타입 혼동은 실제로 많이 발생하고 큰 피해로 이어질 수 있기 때문에, 의미가 다른 값을 "타입 분리"를 통해 미리 방지하는 게 안전
type Duration is uint64;

type Timestamp is uint64;

type Clock is uint128;

// library : 여러 컨트랙트에서 똑같은 로직을 쓰고 싶을 때 코드의 길이를 줄이고 깔끔하게 유지하기 위한 재사용 가능한 함수들의 묶음
library LibClock {
    function encodeClock(Duration _duration, Timestamp _timestamp) internal pure returns (Clock clock_) {
        assembly{
            // assembly : Solidity 안에 쓸 수 있는 Low-Level Language => EVM 바이트코드 직접 제어 => 속도 최적화(gas 절약) + Solidity 문법으로는 못하는 복잡한 연산도 가능
            clock_ := or(shl(0x40, _duration), _timestamp) // Clock은 Duration과 Timestamp(각각 64비트. duration은 상위(왼쪽) 64비트, timestamp는 하위(오른쪽) 64비트)를 하나의 128비트 값으로 패킹한 값
        }
    }

    function duration(Clock _clock) internal pure returns (Duration duration_){
        assembly{
            duration_ := shr(0x40, _clock) // Clock의 상위 64비트를 가져옴
        }
    }

    function timestamp(Clock _clock) internal pure returns (Timestamp timestamp_){
        assembly{
            timestamp_ := shr(0xc0, shl(0xc0, _clock)) // Clock의 하위 64비트를 가져옴
        }
    }
}

library LibClockBasic {
    // LibClock와 다르게 사용자 정의 타입(UVDT)을 사용하지 않고 그냥 uint64, uint128 등의 기본 정수형 타입만으로 clock 값 만드는 라이브러리
    function wrap(uint64 _duration, uint64 _timestamp) internal pure returns (uint128 clock){
        assembly{
            clock := or(shl(0x40, _duration), _timestamp)
        }
    }
}

contract Examples {
    function example_no_uvdt() external view {
        uint128 clock;
        uint64 d = 1;
        uint64 t = uint64(block.timestamp); // d,t 둘 다 그냥 기본 타입
        clock = LibClockBasic.wrap(d,t);
        clock = LibClockBasic.wrap(t,d); // 이건 그냥 반대로 넣어본 것(순서가 바뀌면 완전히 값이 달라짐)
    }

    function example_uvdt() external view {
        // 사용자 정의 타입을 활용해 더 명확하게 clock 값을 조작하는 예제
        // block.timestamp 읽기만 하고, 쓰기 없음 -> 가스 안듦 : view

        // wrap(value) -> 일반값을 사용자 정의 타입으로 감쌈 / unwrap(wrapped) -> 타입을 벗겨서 원래값 꺼냄
        // wrap() 함수를 써서 일반 숫자를 Duration과 Timestamp 타입으로 감쌈
        Duration d = Duration.wrap(1);
        Timestamp t = Timestamp.wrap(uint64(block.timestamp));

        // 반대로, 다시 일반 숫자로 꺼낼 땐 unwrap()을 사용
        // uint64 d_u64 = Duration.unwrap(d);
        // uint64 t_u64 = Timestamp.unwrap(t);

        Clock clock = Clock.wrap(0); // clock 초기화용
        clock = LibClock.encodeClock(d,t); // 사용자 정의 타입인 Duration, Timestamp를 받아 clock 값을 생성
    }
}