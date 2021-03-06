describe Monocle::Url do
  let(:origin) { 'https://monocle.com' }

  its(:origin) { is_expected.to eq(origin) }

  context 'when building radio show url' do
    subject { described_class.new.radio_show_url('the-urbanist') }

    it { is_expected.to eq("#{origin}/radio/shows/the-urbanist/") }
  end

  context 'when building radio show episode url' do
    subject { described_class.new.radio_show_url('the-urbanist', '318') }

    it { is_expected.to eq("#{origin}/radio/shows/the-urbanist/318/") }
  end
end
