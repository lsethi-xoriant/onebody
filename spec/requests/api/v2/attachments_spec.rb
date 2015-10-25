require_relative '../../../rails_helper'

describe 'Attachments API', type: :request do

  it 'should return a list of attachments' do
    FactoryGirl.create_list(:attachment, 10)

    get "/api/v2/attachments"

    expect(response).to be_success
    expect(json_data.length).to eq(10)
    expect(json_data[0]['type']).to eq('attachments')
  end

  it 'should retrieve a specific attachment' do
    attachment = FactoryGirl.create(:attachment)

    get "/api/v2/attachments/#{attachment.id}"

    expect(response).to be_success
    expect(json_data['id'].to_i).to eq(attachment.id)
  end

  it 'should retrieve the attachment message' do
    message = FactoryGirl.create(:message)
    attachment = FactoryGirl.create(:attachment, message: message)

    get "/api/v2/attachments/#{attachment.id}/message"

    expect(response).to be_success
    expect(json_data['id'].to_i).to eq(message.id)
  end
end