use anchor_lang::prelude::*;

declare_id!("YourProgramIDHere1111111111111111111111111111111");

#[program]
pub mod libra {
    use super::*;

    pub fn initialize(ctx: Context<Initialize>) -> Result<()> {
        msg!("Libra Token program initialized!");
        Ok(())
    }
}

#[derive(Accounts)]
pub struct Initialize<'info> {
    #[account(mut)]
    pub payer: Signer<'info>,
    pub system_program: Program<'info, System>,
}
