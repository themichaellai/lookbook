defmodule Lookbook.Helpers do
  defmacro casebind(val, bind_name, do: expr) do
    bound_var = Macro.var(bind_name, nil)
    quote do
      unquote(bound_var) = unquote(val)
      case unquote(bound_var) do
        unquote(expr)
      end
    end
  end
end
