class Root
  def clone
    return Marshal::load(Marshal.dump(self))
  end
end