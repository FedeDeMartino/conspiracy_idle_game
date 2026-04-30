# frozen_string_literal: true

module BaseService
  def call(...)
    __send__(:new, ...).__send__(:call)
  end
end
