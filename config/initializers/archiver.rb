Archived.pluck(:type).uniq.each do |type|
  klass = Class.new(Archived)
  Object.const_set type, klass
end
