# frozen_string_literal: true

module Utils
  class Json
    def self.convert_to_hash(arg)
      return {} if arg.blank?
      return arg if arg.instance_of?(Hash)

      JSON.parse(arg.to_s, symbolize_names: true)
    end
  end
end
