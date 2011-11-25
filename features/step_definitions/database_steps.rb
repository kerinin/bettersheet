Then /^I should have ([0-9]+) suggestions?$/ do |count|
  Suggestion.count.should == count.to_i
end