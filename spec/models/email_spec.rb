require 'rails_helper'

RSpec.describe Email, type: :model do
  describe 'pagination' do
    context "when less than 20 emails" do
      it "return one page" do
          Email.create(object: "My email object",
                      content: "This is the sper content of my test Email",
                      sender: "test@test.test",
                      recipient: "recipient@recipient.com")
        @page, @max_pages, @emails = Email.paginate({page: 1}, Email.all)
        expect(@max_pages).to eq(1)
      end
    end

    context "when request page is under 1" do 
      it "return page 1 " do
        30.times do 
          Email.create(object: "My email object",
                      content: "This is the sper content of my test Email",
                      sender: "test@test.test",
                      recipient: "recipient@recipient.com")
        end

        @page, @max_pages, @emails = Email.paginate({page: -5}, Email.all)
        expect(@page).to eq(1)
      end
    end

    context "when request page is higher than max_pages" do
      it "return max_pages" do
        30.times do 
          Email.create(object: "My email object",
                      content: "This is the sper content of my test Email",
                      sender: "test@test.test",
                      recipient: "recipient@recipient.com")
        end

        @page, @max_pages, @emails = Email.paginate({page: 100}, Email.all)
        expect(@page).to eq(@max_pages)
      end
    end

    context "when request is valid" do
      it "return only 20 mails" do
        50.times do
          Email.create(object: "My email object",
            content: "This is the sper content of my test Email",
            sender: "test@test.test",
            recipient: "recipient@recipient.com")
        end

        @page, @max_pages, @emails = Email.paginate({page: 1}, Email.all)
        expect(@emails.size).to eq(20)
      end
    end
  end
end
