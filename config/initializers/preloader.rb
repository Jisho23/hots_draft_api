module PreloaderPerformance
  private
  def query_scope(ids)
    if ids.count > 100
      type = klass.columns_hash[association_key_name.to_s].sql_type
      values_list = ids.map do |id|
        if id.kind_of?(Integer)
          " (#{id})"
        elsif type == "uuid"
          " ('#{id.to_s}'::uuid)"
        else
          " ('#{id.to_s}')"
        end
      end.join(",")

      scope.where("#{association_key_name} in (VALUES #{values_list})")
    else
      super
    end
  end
end

module ActiveRecord
  module Associations
    class Preloader
      class Association #:nodoc:
        prepend PreloaderPerformance
      end
    end
  end
end
