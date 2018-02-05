pragma solidity ^0.4.18;

contract Owener{
    address public admin;
    function Owener() public{
        admin = msg.sender;
    }
    modifier onlyOwener(){
        require(msg.sender == admin);
        _;
    }
    function transferOwenership(address newAdmin) internal onlyOwener{
        admin = newAdmin;
    }
}
contract Token{
    mapping (address => uint256) balances;
    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply;
    event Transfer(address from, address to, uint256 value);
    
    function Token(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUinis) public{
        balances[msg.sender] = initialSupply;
        totalSupply = initialSupply;
        name = tokenName;
        symbol = tokenSymbol;
        decimal =decimalUinis;
    }
    function transfer(address _to, uint256 _val) public{
        require(balances[msg.sender] > _val);
        
        require(balances[_to] + _val > balances[_to]);
        
        balances[msg.sender] = _val;
        balances[_to] = _val;
        Transfer(msg.sender, _to, _val);
    }
}

contract AssertToken is Owener, Token{
    function AssertToken(uint256 initialSupply, string tokenName, string tokenSymbol, uint8 decimalUinis, address centralAdmin) Token(0,tokenName, tokenSymbol, decimalUinis){
        totalSupply = initialSupply;
        if(centralAdmin != 0){
            admin = centralAdmin;
        }
        else{
            admin = msg.sender;
        }
        balances[admin] = initialSupply;
        totalSupply = initialSupply;
    }
    
    function mintToken(address target, uint256 mintedAmount){
        balances[target] += mintedAmount;
        totalSupply += mintedAmount;
        Transfer(0,this,mintedAmount);
        Transfer(this,target, mintedAmount);
    }
    function transfer(address _to, uint256 _value) public{
        require(balances[msg.sender] > 0);
        require(balances[msg.sender] > _value);
        
        require(balances[_to] + _value > balances[_to]);
        
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        Transfer(msg.sender, _to, _value);
        
    }
}



