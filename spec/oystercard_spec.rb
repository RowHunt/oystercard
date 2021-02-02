require 'oystercard.rb'

describe Oystercard do
  MONEY = 1
  describe "balance" do
    it "displays balance" do
      expect(subject.balance).to eq(0)
    end
  end
  describe "top_up" do
    it "adds money to balance" do
      subject.top_up(MONEY)
      expect(subject.balance).to eq(MONEY)
    end
    it "limits balance" do
      subject.top_up(Oystercard::LIMIT)
      expect{subject.top_up(MONEY)}.to raise_error("Invalid. The limit is #{Oystercard::LIMIT}")
    end
  end
  describe "touch_in" do
    it "card in use" do
      subject.top_up(MONEY)
      subject.touch_in
      expect(subject.in_journey).to eq true
    end
    context "card has no balance" do
      it "card cannot be used" do
        expect{subject.touch_in}.to raise_error "Insufficient funds."
      end
    end
  end
  describe "touch_out" do
    it "card not in use" do
      subject.touch_out
      expect(subject.in_journey).to eq false
    end
    it "decreases balance at touch_out" do
      subject.top_up(5)
      subject.touch_in
      expect{subject.touch_out}.to change{subject.balance}.by(-1)
    end
  end
end