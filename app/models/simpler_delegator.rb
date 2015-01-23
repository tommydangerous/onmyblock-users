class SimplerDelegator < SimpleDelegator
  alias_method :object, :__getobj__
end
