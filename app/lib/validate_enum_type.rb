# NOTE: To be removed. Commented out for now.
#       Failed in GitHub build with this error:
#         Expected file #{file} to define constant #{cpath}, but didn't
# # override ActiveRecord::Enum::EnumType's assert_valid_value
# class ValidatableEnumType < ActiveRecord::Enum::EnumType
#   # return value supressing <ArgumentError> found in
#   # https://github.com/rails/rails/blob/main/activerecord/lib/active_record/enum.rb#L171
#   def assert_valid_value(value)
#     value
#   end
# end