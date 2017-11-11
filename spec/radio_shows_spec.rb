describe 'Radio Shows' do
  before { visit radio_show_url(show) }

  context 'The Urbanist' do
    let(:show) { 'the-urbanist' }
    let(:first_article_link) { page.first('.tb_desc-link') }

    example 'Latest article is valid' do
      first_article_link.click
      assert_page_has_title
      assert_page_has_hero
      assert_page_has_description
    end

    example 'Soon to be released article is valid' do
      visit next_article_url
      assert_page_has_title
      assert_page_has_hero
      assert_page_has_description
    end
  end

  # Based on current URL, we guess the next article URL by incrementing the ID
  # found in the current URL.
  #
  # Example:
  #
  #   https://monocle.com/radio/shows/the-urbanist/318/
  #
  #   becomes:
  #
  #   https://monocle.com/radio/shows/the-urbanist/319/
  #
  def next_article_url
    article_number = first_article_link['href'].scan(/\/(\d+)\//)[0][0]
    next_article_number = article_number.to_i.next.to_s
    next_article_url = first_article_link['href'].sub(article_number, next_article_number)
  end

  # We assert the the <h1> content is found
  def assert_page_has_title
    expect(page.title).to_not start_with('The Urbanist')
    expect(page.title).to include(page.find('h1').text)
  end

  def assert_page_has_hero
    hero_style_attr = page.find('.radio-hero')['style']
    expect(hero_style_attr).to_not include('generic-episode-photo')
    expect(hero_style_attr).to include('jpg')
  end

  def assert_page_has_description
    expect(page.find('.meta-summary').text).to_not eq('With an influential audience of city mayors')
  end
end
