require 'spec_helper'

describe AwesomeZanox::Resources do
  it '#signature' do
    resource = AwesomeZanox::Client.new('802B8BF4AE99EBE00F41', 'fa4c0c2020Aa4c+ab9Ea0ec8d39E06/df2c5aa44')

    date  = '2013-08-20T14:44:21'
    nonce = 'b382e074-2fc4-41c9-8d5c-f679805f609c'
    signature = resource.signature('publisherservice', 'getsales', date, nonce)

    expect(signature).to eq('aK6w2dT5X1y9E51FTv0rIU7INZc=')
  end
end
