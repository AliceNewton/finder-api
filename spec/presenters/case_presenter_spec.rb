require "spec_helper"

require "presenters/case_presenter"

describe CasePresenter do
  subject(:case_presenter) { CasePresenter.new(schema, case_data) }

  let(:case_data) {
    {
      "title" => case_title,
      "case_type" => case_type_value,
      "body" => case_body,
    }
  }

  let(:case_body) { "## Case Body" }
  let(:case_title) { "Heathcorp / Druginc merger inquiry" }
  let(:case_type_value) { "criminal-cartels" }
  let(:case_type_label) { "CA98 and civil cartels" }

  let(:schema) {
    double(
      :schema,
      facets: ["case_type"],
    ).tap { |d|
      allow(d).to receive(:label_for)
        .with("case_type", case_type_value)
        .and_return(case_type_label)
    }
  }

  describe "#to_h" do
    it "directly presents normal fields" do
      expect(case_presenter.to_h).to include( "title" => case_title )
    end

    it "filters out the body field" do
      expect(case_presenter.to_h).not_to have_key("body")
    end

    it "expands multi-select fields to include the label and value" do
      expected_case_type_data = {
        "case_type" => {
          "label" => case_type_label,
          "value" => case_type_value,
        }
      }

      expect(case_presenter.to_h).to include( expected_case_type_data )
    end

    context "when the case data is missing a multi-select field" do
      let(:case_data) {
        {
          "title" => case_title,
        }
      }

      it "presents the available fields" do
        expect(case_presenter.to_h).to include(case_data)
      end
    end
  end
end
