require "rails_helper"

describe FullContactLookup do 
  describe "#by_email" do

    it "will return the objects data property if email is already in the database" do 
      obj = FullContactLookup.new(email: "example@aol.com", data: { one: "1" })
      obj.save!

      expect(FullContactLookup.by_email("example@aol.com")).to eq({ one: "1" })
    end

    it "will handle the case when no arguments are passed" do 
      expect(FullContactLookup.by_email()).to eq(nil)
    end

    it "will only accept emails that include the @ symbol" do 
      expect(FullContactLookup.by_email("jgabriels30gmail.com")).to eq(nil)
    end

    it "will save valid emails to the DB" do
      FullContactLookup.by_email("jgabriels30@gmail.com")
      lookup = FullContactLookup.find_by(email: "jgabriels30@gmail.com")

      expect(lookup.email).to eq("jgabriels30@gmail.com")
    end

    it "should save non-existant emails to the database with the data set to nil" do 
      FullContactLookup.by_email("nonexistantemail@abcdefghijklmnop123")
      lookup = FullContactLookup.find_by(email: "nonexistantemail@abcdefghijklmnop123")
      expect(lookup.email).to eq("nonexistantemail@abcdefghijklmnop123")
      expect(lookup.data).to eq(nil)
    end
  end
end 