# 🧜‍♀️ Aqueduct

Grow your ecosystem in a truly decentralized way.

As your project gains revenue, earns protocol fees, or inflates token supply,
siphon off a portion into an aqueduct contract. When a threshold is met, an Allo
grants round can be triggered by anyone, kicking off a distribution of funds
back to the ecosystem.

## Usage

Deploy the [`Aqueduct.sol`](./src/Aqueduct.sol) contract using the provided
deploy scripts and transfer ownership to your community's democratic, onchain
governance system.

You'll then want to set up a way for your aqueduct to be filled by protocol
fees, token inflation, or some other means. You can use a [splits
contract](https://www.0xsplits.xyz/) for this. Or you can build it into your
protocol that the aqueduct is filled.

When your aqueduct meets it's token threshold, anyone in the community can
invoke `release` to kick-off and fund a grants round.

### Considerations

**Ownership:** What address will own your aqueduct. This address will have
important permissions that configure the aqueduct and the allocation rounds it
creates. It would be best to have the contract owned by a democratic, on-chain
governance system.

**Round Size and Cadence:** The aqueduct will transfer the entire balance of
a given token into a round on release. As your ecosystem grows, this could mean
that rounds happen more frequently, because the aqueduct refills faster.

## Disclaimer

_These smart contracts are being provided as is. No guarantee, representation or
warranty is being made, express or implied, as to the safety or correctness of
the user interface or the smart contracts. They have not been audited and as
such there can be no assurance they will work as intended, and users may
experience delays, failures, errors, omissions, loss of transmitted information
or loss of funds. The creators are not liable for any of the foregoing. Users
should proceed with caution and use at their own risk._

## License

See [LICENSE](./LICENSE) for more details.
