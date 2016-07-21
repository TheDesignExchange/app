class SearchFilterHash

  def initialize(facets, applied_cg_filters)
    @cat_facet = facets.find { |f| f.name == :method_category_ids }
    @char_facet = facets.find { |f| f.name == :characteristic_ids }
    # gather all checked characteristic ids from sidebar so we can properly render
    # them as still checked when we return results
    @filtered_chars = applied_cg_filters.collect {|cg_id, char_ids| char_ids}.flatten.map(&:to_i)
  end

  def build_hash
    MethodCategory.order(:process_order).map do |c|
      category_hash(c)
    end
  end

  private

  def category_hash(category)
    hit_count = get_facet_count(@cat_facet, category.id)
    return {name: category.name,
            id: category.id,
            count: hit_count,
            char_groups: build_char_group_hashes(category)}
  end

  def build_char_group_hashes(category)
    return category.characteristic_groups.order(:name).map do |cg|
      char_group_hash(cg)
    end
  end

  def char_group_hash(cg)
    return {name: cg.name,
            id: cg.id,
            chars: build_char_hashes(cg)}
  end

  def build_char_hashes(cg)
    return cg.characteristics.order(:name).map do |char|
      char_hash(char)
    end
  end

  def char_hash(char)
    hit_count = get_facet_count(@char_facet, char.id)
    is_checked = @filtered_chars.include?(char.id)
    return {name: char.name,
            id: char.id,
            count: hit_count,
            is_checked: is_checked}
  end

  def get_facet_count(facet, id)
    row = facet.rows.find {|r| r.value == id}
    return row.nil? ? 0 : row.count
  end
end
