class Transfer
    attr_accessor :sender, :receiver, :status, :amount

    def initialize(sender, receiver, status = 'pending', amount)
        @sender = sender
        @receiver =receiver
        @status = status
        @amount = amount
    end 

    def valid?
     @sender.valid? && @receiver.valid?
    end

    def execute_transaction
      if @sender.balance > @amount && @status == "pending" && self.valid?
        @receiver.deposit(@amount)
        @sender.deposit(-@amount)
        @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end 

    def reverse_transfer
      if @receiver.balance > @amount && @status == "complete"
        @sender.deposit(@amount)
        @receiver.deposit(-@amount)
        @status = "reversed"
      
      end 
    end
end
