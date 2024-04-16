const makeWithdraw = balance => {
  return amount => { 
    if(balance >= amount) {
      balance -= amount
      return balance
    }
    else return 'Insufficient funds'
  }
}

const W1 = makeWithdraw(100)
const W2 = makeWithdraw(100)

W1(50)
W1(70)
