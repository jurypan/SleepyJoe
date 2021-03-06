import { tokens, EVM_REVERT } from './helpers';

const Exchange = artifacts.require('./Exchange');

require('chai')
    .use(require('chai-as-promised'))
    .should();



contract('Exchange', ([deployer, feeAccount]) => {

    let exchange = null;

    beforeEach(async () => {
        exchange = await Exchange.new(feeAccount);
    });


    describe('deployment', async () => {
        it('tracks a fee account', async () => {
            const result = await exchange.feeAccount();
            result.should.equal(feeAccount);
        });
    });
});

