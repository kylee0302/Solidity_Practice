// SPDX-License-Identifier:GPL-3.0
pragma solidity >=0.7.0 < 0.9.0;

contract EtherUnits {
    uint256 public oneWei = 1 wei; // wei는 이더리움의 가장 작은 단위, 1 wei는 숫자 1과 같음

    bool public isOneWei = (oneWei == 1); // True

    uint256 public oneGwei = 1 gwei; // 1 gwei는 1,000,000,000 wei = 10^9 wei
    
    bool public isOneGwei = (oneGwei == 1e9); // true

    uint256 public oneEther = 1 ether; // 1 ether는 1,000,000,000,000,000,000 wei = 10^18 wei

    bool public isOneEther = (oneEther == 1e18); // true
    // Solidity에서 wei, gwei, ether 각각은 고정된 값으로, 컴파일 타임에 숫자값으로 변환됨
}