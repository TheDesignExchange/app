def words text
  text.downcase.scan(/[a-z]+/)
end

def train features
  model = Hash.new(1)
  features.each {|f| model[f] += 1 }
  return model
end



def edits1 word
  path = File.join Rails.root, 'lib', 'dx.txt'
  nwords = train(words(File.new(path).read))
  letters = ("a".."z").to_a.join
  n = word.length
  deletion = (0...n).collect {|i| word[0...i]+word[i+1..-1] }
  transposition = (0...n-1).collect {|i| word[0...i]+word[i+1,1]+word[i,1]+word[i+2..-1] }
  alteration = []
  n.times {|i| letters.each_byte {|l| alteration << word[0...i]+l.chr+word[i+1..-1] } }
  insertion = []
  (n+1).times {|i| letters.each_byte {|l| insertion << word[0...i]+l.chr+word[i..-1] } }
  result = deletion + transposition + alteration + insertion
  result.empty? ? nil : result
end

def known_edits2 word
  path = File.join Rails.root, 'lib', 'dx.txt'
  nwords = train(words(File.new(path).read))
  letters = ("a".."z").to_a.join
  result = []
  edits1(word).each {|e1| edits1(e1).each {|e2| result << e2 if nwords.has_key?(e2) }}
  result.empty? ? nil : result
end

def known words
  path = File.join Rails.root, 'lib', 'dx.txt'
  nwords = train(words(File.new(path).read))
  letters = ("a".."z").to_a.join
  result = words.find_all {|w| nwords.has_key?(w) }
  result.empty? ? nil : result
end

def correct word
  path = File.join Rails.root, 'lib', 'dx.txt'
  nwords = train(words(File.new(path).read))
  letters = ("a".."z").to_a.join
  (known([word]) or known(edits1(word)) or known_edits2(word) or
    [word]).max {|a,b| nwords[a] <=> nwords[b] }
end