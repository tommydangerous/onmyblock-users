RSpec.shared_examples :crud do
  before { subject.save }

  it "should create" do
    expect(subject).to be_persisted
  end

  it "should read" do
    expect(subject).to eq subject.class.find(subject.id)
  end

  it "should update" do
    expect(subject.save).to eq true
  end

  it "should destroy" do
    action = -> { expect(subject.destroy).to be true }
    expect(action).to change(subject.class, :count)
  end
end
