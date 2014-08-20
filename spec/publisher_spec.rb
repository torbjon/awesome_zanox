require 'spec_helper'

describe AwesomeZanox::Publisher do
  before do
    @client = AwesomeZanox::Client.new('802B8BF4AE99EBE00F41', 'fa4c0c2020Aa4c+ab9Ea0ec8d39E06/df2c5aa44')
    savon.mock!
  end    

  after do
    savon.unmock!
  end

  it '#get_profiles' do
    message = @client.auth_message('publisherservice', 'getprofile', 'some_date', 'some_nonce')
    savon.expects(:get_profile).with(message: message).returns(fixture('get_profile.xml'))
  
    profile = @client.publisher.get_profile({}, 'some_date', 'some_nonce')
    expect(profile[:get_profile_response][:profile_item][:first_name]).to eq('Maksim')
  end

  it '#get_program_applications' do
    message = @client.auth_message('publisherservice', 'getprogramapplications', 'some_date', 'some_nonce')
    savon.expects(:get_program_applications).with(message: message).returns(fixture('get_program_applications.xml'))
  
    profile = @client.publisher.get_program_applications({}, 'some_date', 'some_nonce')
    expect(profile[:get_program_applications_response][:program_application_items][:program_application_item][0][:program]).to eq('ABC')
  end

  it '#get_admedia' do
    message = @client.message()
    savon.expects(:get_admedia).with(message: message).returns(fixture('get_admedia.xml'))
  
    profile = @client.publisher.get_admedia    
    expect(profile[:get_admedia_response][:admedium_items][:admedium_item][0][:name]).to eq('Generic_DE_120x600')
  end
end
