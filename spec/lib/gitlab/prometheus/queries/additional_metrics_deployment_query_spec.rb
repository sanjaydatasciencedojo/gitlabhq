require 'spec_helper'

describe Gitlab::Prometheus::Queries::AdditionalMetricsDeploymentQuery, lib: true do
  include Prometheus::AdditionalMetricsQueryHelper
  include Prometheus::MetricBuilders

  let(:metric_group_class) { Gitlab::Prometheus::MetricGroup }
  let(:metric_class) { Gitlab::Prometheus::Metric }

  let(:client) { double('prometheus_client') }
  let(:environment) { create(:environment, slug: 'environment-slug') }
  let(:deployment) { create(:deployment, environment: environment) }

  subject(:query_result) { described_class.new(client).query(deployment.id) }

  around do |example|
    Timecop.freeze { example.run }
  end

  include_examples 'additional metrics query' do
    it 'queries using specific time' do
      expect(client).to receive(:query_range).with(anything,
                                                   start: (deployment.created_at - 30.minutes).to_f,
                                                   stop: (deployment.created_at + 30.minutes).to_f)

      expect(query_result).not_to be_nil
    end
  end
end
