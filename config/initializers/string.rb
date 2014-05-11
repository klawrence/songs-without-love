class Symbol

  def localize_with_debugging(*args)
    localized_sym = I18n.translate(self, *args)
    localized_sym.is_a?(String) ? localized_sym.html_safe : localized_sym
  end
  alias_method :l, :localize_with_debugging

  def l_with_args(*args)
    self.l(*args).html_safe
  end

end

# Symbol.send :include, SymbolExtensionCustom
