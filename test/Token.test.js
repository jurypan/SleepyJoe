import { tokens, EVM_REVERT } from './helpers';

const Token = artifacts.require('./Token');

require('chai')
    .use(require('chai-as-promised'))
    .should();



contract('Token', ([deployer, sender, receiver]) => {

    const name = 'Sleepy Joe';
    const symbol = 'JPX';
    const decimals = '18';
    const totalSupply = tokens(1000000).toString();
    let token = null;

    beforeEach(async () => {
        token = await Token.new();
    });


    describe('deployment', async () => {
        it('tracks the name', async () => {
            const result = await token.name();
            result.should.equal(name);
        });

        it('tracks the symbol', async () => {
            const result = await token.symbol();
            result.should.equal(symbol);
        });

        it('tracks the decimals', async () => {
            const result = await token.decimals();
            result.toString().should.equal(decimals);
        });

        it('tracks the total supply', async () => {
            const result = await token.totalSupply();
            result.toString().should.equal(totalSupply);
        });

        it('assign the total supply to the deployer', async () => {
            const result = await token.balanceOf(deployer);
            result.toString().should.equal(totalSupply);
        });
    });

    describe('sending tokens', async () => {
        let amount = null;
        let result = null;

        describe('success', async () => {

            beforeEach(async () => {
                amount = tokens(100);
                result = await token.transfer(receiver, amount, { from: deployer });
            });

            it('transfers token balances', async () => {
                let balanceOf;
                balanceOf = await token.balanceOf(deployer);
                balanceOf.toString().should.equal(tokens(999900).toString());
                console.log("deployer balance after transfer", balanceOf.toString());
                balanceOf = await token.balanceOf(receiver);
                balanceOf.toString().should.equal(tokens(100).toString());
                console.log("receiver balance after transfer", balanceOf.toString());
            });

            it('emits a transfer events', async () => {
                const log = result.logs[0];
                log.event.should.eq('Transfer');
                const event = log.args;
                event.from.toString().should.equal(deployer, 'from is correct');
                event.to.should.equal(receiver, 'to is correct');
                event.value.toString().should.equal(amount.toString(), 'amount is correct');
            });
        });

        describe('failure', async () => {

            it('rejects insuffient balances', async () => {
                let invalidAmount = tokens(100000000); // 100 - million -> greater than total supply
                await token.transfer(receiver, invalidAmount, { from: deployer }).should.be.rejectedWith(EVM_REVERT);
            
                // Attempt transfer tokens, when you have none
                invalidAmount = tokens(10); // recipient has no tokens
                await token.transfer(deployer, invalidAmount, { from: receiver }).should.be.rejectedWith(EVM_REVERT);
            });

            it('rejects invalid recipients', async () => {
                await token.transfer(0x0, tokens(100), { from: deployer }).should.be.rejected;
            });
        });
    });

});