module Application
  module TestHelpers
    def use_fixture(fixture_name)
      before :each do
        FileUtils.copy(fixture_path_for(fixture_name), "#{Application.root}/db/#{Sinatra::Base.environment}.yml")
      end
    end

    def fixture_path_for(fixture_name)
      "#{Application.root}/spec/fixtures/#{fixture_name}.yml"
    end
  end
end