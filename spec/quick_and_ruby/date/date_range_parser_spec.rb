# frozen_string_literal: true

require 'quick_and_ruby/date'

RSpec.describe 'QuickAndRuby::Date::DateRangeParser' do
  #    let(:argv) { [] }
  #   subject { described_class.new(argv) }

  #   context "full date range parsing" do
  #     it "defines begin and end of time range" do
  #       parsed_options = subject.parse

  #       require 'byebug'
  #       byebug
  #     end

  #     it "allows definition of time increment" do
  #     end

  #     it "allows definition of time print format" do
  #     end
  #   end

  #   context "small date range parsing" do
  #     it "defines begin and end of time range" do
  #     end

  #     it "allows definition of time increment" do
  #     end

  #     it "allows definition of time print format" do
  #     end
  #   end

  #   context "when -h or --help option used" do
  #     let(:expected_help_output) do
  #       %(Usage: daterange [options] time-begin time-end
  #     -h, --help                       Show this message
  #         --version                    Show version
  #     -i, --incr=INCR                  Increment by INCR
  #     -f, --format=FORMAT              FORMAT for printing date
  # )
  #     end

  #     it "prints the help and exits on -h option" do
  #       argv << "-h"
  #       expect do
  #         expect { subject.parse }.to raise_error(SystemExit)
  #       end.to output(expected_help_output).to_stdout
  #     end

  #     it "prints the help and exits on --help option" do
  #       argv << "--help"
  #       expect do
  #         expect { subject.parse }.to raise_error(SystemExit)
  #       end.to output(expected_help_output).to_stdout
  #     end
  #   end

  #   context "when --version option used" do
  #     let(:expected_version_output) { /#{::QuickAndRuby::VERSION}/ }

  #     it "prints the version and exists" do
  #       argv << "--version"
  #       expect do
  #         expect { subject.parse }.to raise_error(SystemExit)
  #       end.to output(expected_version_output).to_stdout
  #     end
  #   end
end
