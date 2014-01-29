require 'sinatra'
require 'json'

class FinderApi < Sinatra::Application
  get '/finders/:slug/documents.json' do
    content_type :json
    case params['case_type']
    when 'merger-inquiries'
      merger_inquiry_cases_json
    else
      all_cases_json
    end
  end

  def all_cases_json
    {
      document_noun: 'case',
      documents: [
        {
          title: 'HealthCorp / DrugInc merger inquiry',
          metadata: [
            { type: 'date', name: 'date_referred', value: '2003-12-30' },
            { type: 'text', name: 'case_type', value: 'Merger inquiry' }
          ]
        },
        {
          title: 'Private healthcare market investigation',
          metadata: [
            { type: 'date', name: 'date_referred', value: '2007-08-14' },
            { type: 'text', name: 'case_type', value: 'Market investigation' }
          ]
        }
      ]
    }.to_json
  end

  def merger_inquiry_cases_json
    {
      document_noun: 'case',
      documents: [
        {
          title: 'HealthCorp / DrugInc merger inquiry',
          metadata: [
            { type: 'date', name: 'date_referred', value: '2003-12-30' },
            { type: 'text', name: 'case_type', value: 'Merger inquiry' }
          ]
        }
      ]
    }.to_json
  end
end
