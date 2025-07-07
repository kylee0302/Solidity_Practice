// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract Loop{
    function loop() public pure{
        for (uint256 i = 0; i < 10; i++){ // 3에서 건너뛰고, 5에서 멈춤
            if(i==3){
                continue;
            }
            if(i==5){
                break;
            }
        }

        uint256 j; // 변수 j는 초기값 0
        while(j < 10){
            j++;
        }
    }
}