module Flipper
  extend self

  class DSL
    def disabled?(name, *args)
      !enabled?(name, *args)
    end
  end

  def_delegator :instance, :disabled?
end
