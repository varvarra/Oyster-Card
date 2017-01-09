require 'oystercard'

describe Oystercard do
  it 'Has default balance of 0 when created' do
    expect(subject.balance).to eq 0
  end
  it 'Can Top Up' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end
  it 'Tops up by the amount provided' do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end
  it 'Can Deduct' do
    expect(subject).to respond_to(:deduct).with(1).argument
  end
  it 'Deducts the amount provided' do
    subject.top_up(10)
    subject.deduct(5)
    expect(subject.balance).to eq 5
  end

  context "when the limit balance is reached" do
  it 'it can not have a balance greater than £90' do
    subject.top_up(Oystercard::LIMIT)
    expect{subject.top_up(1)}.to raise_error "The balance has a limit of £#{Oystercard::LIMIT}"
  end

  it 'has working above_limit? method' do
    subject.top_up(Oystercard::LIMIT)
    expect(subject.above_limit?(Oystercard::LIMIT)).to eq true
  end

  context "when using a card" do
    describe "touching in and out" do
      it "responds to in_journey? quesiton" do
        expect(subject.respond_to? :in_journey?). to eq true
      end
      it "correctly checks if in_journey?" do
        expect(subject.in_journey?).to eq false
      end
      it "can touch in" do
        expect(subject.respond_to? :touch_in).to eq true
      end
      it "does touch in" do
        subject.touch_in
        expect(subject.in_use).to eq true
      end
      it "does touch out" do
        subject.touch_in
        subject.touch_out
        expect(subject.in_use).to eq false
      end
    end
  end

end
end
