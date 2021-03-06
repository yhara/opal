require 'opal/nodes/base_scope'

module Opal
  module Nodes
    class SingletonClassNode < BaseScopeNode
      handle :sclass

      children :object, :body

      def compile
        push "(function(self) {"

        in_scope(:sclass) do
          add_temp '$scope = self._scope'
          add_temp 'def = self._proto'

          line scope.to_vars
          line stmt(body)
        end

        line "})(", recv(object), ".$singleton_class())"
      end
    end

  end
end
