// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ERC20 } from "solmate/tokens/ERC20.sol";
import { Owned } from "solmate/access/Ownable.sol";

/// @title Aqueduct
/// @author 0xZakk (https://www.twitter.com/0xZakk)
/// @notice A timelock-style, treasury contract for holding funds until a certain threshold is met, then releasing them to a quadratic funding round.
/// @dev This contract works with any ERC20 token, but is not written to work with more than one token or with native Eth. This contract is a work in progress and is not yet audited. Use at your own risk.
contract Aqueduct is Owned {
  //
  // Type declarations
  //

  //
  // State variables
  //
  /// @notice The token held by this aqueduct and used in quadratic funding rounds.
  ERC20 public token;

  /// @notice The address of the program that owns the rounds that will receive funds from this aqueduct.
  address public program;

  /// @notice Mapping of whitelisted rounds.
  mapping(address => bool) public approvedRounds;

  /// @notice The amount of funds that need to be deposited before the aqueduct will release funds to the quadratic funding round.
  uint256 public threshold;

  //
  // Events
  //
  /// @notice Emitted when funds are deposited into the aqueduct.
  event Deposit(address indexed depositor, uint256 amount);

  /// @notice Emitted when funds are released from the aqueduct to the quadratic funding round.
  event Release(address indexed round, uint256 amount);

  /// @notice Emitted when the program address is changed.
  event ProgramSet(address indexed newProgram);

  /// @notice Emitted when the threshold is changed.
  event ThresholdSet(uint256 newThreshold);

  //
  // Modifiers
  //

  //
  // Functions
  //
  constructor (address _token, address _program, uint256 _threshold) public {
    token = ERC20(_token);
    setProgram(_program);
    setThreshold(_threshold);
  }

  /// @notice Releases funds to a quadratic funding round.
  /// @dev Can only be called if the threshold is met and the recipient is a round owned by the program.
  /// @param _round The address of the quadratic funding round to release funds to.
  function release(address _round) external {
    // TODO: Create a new round here, then fund it. Do this to solve the isue of having to whielist rounds or somehow verify them
    require(token.balanceOf(address(this)) >= threshold, "Aqueduct: Threshold not met");
    require(approvedRounds[_round], "Aqueduct: Round not approved");

    emit Release(_round, threshold);
  }

  /// @notice Whitelist a new round to receive funds from this aqueduct.
  /// @dev Only the owner can call this function.
  /// @param _round The address of the quadratic funding round to whitelist.
  /// @param _status Whether or not the round is approved.
  function setRoundApproval(address _round, bool _status) external onlyOwner {
    require(_round != address(0), "Aqueduct: Invalid round address");

    approvedRounds[_round] = _status;
    emit RoundWhitelisted(_round, _status);
  }

  /// @notice Sets the value of the program state variable.
  /// @dev Only the owner can call this function.
  /// @param _program The new address of the program.
  function setProgram(address _program) external onlyOwner {
    emit ProgramSet(program = _program);
  }

  /// @notice Sets the value of the threshold state variable.
  /// @dev Only the owner can call this function.
  /// @param _threshold The new threshold value.
  function setThreshold(uint256 _threshold) external onlyOwner {
    emit ThresholdSet(threshold = _threshold);
  }
}


