require 'oystercard'

describe Oystercard do
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  MONEY = 1
  describe 'balance' do
    it 'displays balance' do
      expect(subject.balance).to eq(0)
    end
  end
  describe '#top_up' do
    it 'adds money to balance' do
      subject.top_up(MONEY)
      expect(subject.balance).to eq(MONEY)
    end
    it 'limits balance' do
      subject.top_up(Oystercard::LIMIT)
      expect { subject.top_up(MONEY) }.to raise_error("Invalid. The limit is #{Oystercard::LIMIT}")
    end
  end
  describe '#touch_in' do
    it 'card in use' do
      subject.top_up(MONEY)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to eq true
    end
    context 'card has no balance' do
      it 'card cannot be used' do
        expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient funds.'
      end
    end
    it 'stores the entry station' do
      subject.top_up(MONEY)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
    # it 'keeps history entry and exit station' do
    #   subject.top_up(MONEY + 1)
    #   subject.touch_in("rogers station")
    #   subject.touch_out("jones station")
    #   subject.touch_in("a station")
    #   subject.touch_out("b station")
    #   expect(subject.history).to eq [{entry: "rogers station", exit: "jones station"},{entry: "a station", exit: "b station"}]
    # end
  end
  describe '#touch_out' do
    it 'card not in use' do
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq false
    end
    it 'decreases balance at touch_out' do
      subject.top_up(MONEY)
      subject.touch_in('rogers station')
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end

    it 'stores the exit station' do
      subject.top_up(MONEY)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end
end
