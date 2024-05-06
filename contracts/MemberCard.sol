// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// OpenZeppelinのERC-20をインポート
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// オーナー権限を管理するコントラクトを追加
import "@openzeppelin/contracts/access/Ownable.sol";
// 投票に必要な拡張コントラクトを追加
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
// アクセス制御するコントラクトを追加
import "@openzeppelin/contracts/access/AccessControl.sol";

// ERC-20を継承
contract MyERC20 is ERC20, Ownable, ERC20Permit, ERC20Votes, AccessControl {

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // トークン名と単位を渡す
    constructor() ERC20("MyERC20", "ME2") ERC20Permit("MyERC20") {
        // トークン作成者に1000000渡す
        _mint(msg.sender, 1000000);
        Ownable(msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    /**
    * @dev トークンを発行（Mint）
    * この関数はMINTER_ROLEを持つアドレスだけが呼び出すことができる
    * @param to トークンの受け取り先アドレス
    * @param amount 発行量
    */
    function mint(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        _mint(to, amount);
    }

    /** 
    * @dev トークンを発行する内部関数
    * ERC20とERC20Votesでオーバーライドが必要
    * @param to トークンの受け取り先アドレス
    * @param amount 発行量
    */
    function _mint(address to, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._mint(to, amount);
    }

    /**
    * @dev トークンの転送後に呼び出される内部関数
    * ERC20とERC20Votesでオーバーライドが必要
    * @param from 送信元アドレス
    * @param to 送信先アドレス
    * @param amount 転送量
    */
    function _afterTokenTransfer(address from, address to, uint256 amount) internal override(ERC20, ERC20Votes) {
        super._afterTokenTransfer(from, to, amount);
    }

    /**
    * @dev トークンを焼却する内部関数
    * ERC20とERC20Votesでオーバーライドが必要
    * @param account 焼却するトークンの所有者アドレス
    * @param amount 焼却量
    */
   function _burn(address account, uint256 amount) internal override(ERC20, ERC20Votes) {
    super._burn(account, amount);
   }

   /**
   * @dev MINTER_ROLEを新たなアドレスに割り当てる
   * この関数はコントラクトのオーナーだけが呼び出すことができる
   * @param minterAddress MINTER_ROLEを割り当てるアドレス
   */
  function grantMinterRole(address minterAddress) public onlyOwner{
    _grantRole(MINTER_ROLE, minterAddress);
  }

  /**
  * @dev タイムスタンプベースでチェックポイントを実装するために時間を返す
  * ERC6372ベースでブロックベースではなくタイムスタンプベースのGovetnorに使用される
  * Hardhatでのテストネットワークではテストできないため利用しない
  * @return 現在のタイムスタンプ
  */
//  function clock() public view override returns (uint48) {
//     return uint48(block.timestamp);
//  }

    /**
    * @dev このGovernorがタイムスタンプベースで動作することを示すモード情報を返す
    * @return タイムスタンプベースのモードを示す文字列
    */
//    function CLOCK_MODE() public pure override returns (string memory) {
//     return "mode=timestamp";
//    }
}