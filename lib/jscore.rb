require 'set'

module Jscore

  def self.similarity(a, b)
    a = a.nil? ? {} : a
    b = b.nil? ? {} : b

    keys_a = a.keys.to_set
    keys_b = b.keys.to_set
    all_keys = keys_a | keys_b

    all_keys.reduce({score:0.0, cap:0.0}) do |s, k|
      # Not sure about this yet but want to try just final_score = score/sum(all_keys)
      # for each key score there is a value score hence +2
      s[:cap] += 2
      if a.member? k and b.member? k
        #puts "score: #{s[:score]}, k:#{k}"
        s[:score] += 1

        #if they are both hashes recur
        if a[k].is_a? Hash and b[k].is_a? Hash
          partial_score = self.similarity(a[k], b[k])
          s[:score] += partial_score[:score]
          s[:cap] += partial_score[:cap]
        end

        #if they are both lists traverse the larger one recurring
        if a[k].is_a? Array and b[k].is_a? Array
          large = a[k].length() > b[k].length() ? a[k] : b[k]

          score_list = large.map.with_index do |item, idx|
            self.similarity(a[k][idx], b[k][idx])
          end

          score_list.reduce({score:0.0, cap:0.0}) do |_, scores|
            s[:score] += scores[:score]
            s[:cap] += scores[:cap]
          end
        end

        #TODO: Use better if/else to reduce logic complexity and DRY
        # if they are leaves (not hash or list)
        # then compare values
        if not a[k].is_a? Array and not b[k].is_a? Array or
          not a[k].is_a? Hash and not b[k].is_a? Hash
          if a[k] == b[k]
            s[:score] += 1
          end
        end
      end
      s
    end
  end


end
