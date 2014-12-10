require "rails_helper"

RSpec.describe ApiConstraints do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1) }
  let(:api_constraints_v2) { ApiConstraints.new(version: 2, default: true) }
  let(:host) { "127.0.0.1:3000" }

  describe "matches?" do
    it "returns true when the version matches the 'Accept' header" do
      request = double(
        host:    host, 
        headers: { "Accept" => "application/vnd.users.v1" }
      )
      expect(api_constraints_v1.matches?(request)).to eq true
    end

    it "returns the default version when 'default' option is specified" do
      request = double(host: host)
      expect(api_constraints_v2.matches?(request)).to eq true
    end
  end
end
