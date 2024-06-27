default_platform(:ios)

platform :ios do
  desc "Build the iOS app"
  lane :build do |options|
    scheme = options[:scheme] || ENV['DEFAULT_SCHEME']
    project = Dir["*.xcodeproj"].first
    workspace = Dir["*.xcworkspace"].first

    build_file = workspace ? workspace : project
    build_type = workspace ? "workspace" : "project"

    xcodebuild(
      scheme: scheme,
      destination: "generic/platform=iOS Simulator",
      build: true,
      build_type.to_sym => build_file,
      build_for_testing: true
    )
  end

  desc "Run tests for the iOS app"
  lane :test do |options|
    scheme = options[:scheme] || ENV['DEFAULT_SCHEME']
    project = Dir["*.xcodeproj"].first
    workspace = Dir["*.xcworkspace"].first

    test_file = workspace ? workspace : project
    test_type = workspace ? "workspace" : "project"

    xcodebuild(
      scheme: scheme,
      destination: "platform=iOS Simulator,name=iPhone 14",
      build: false,
      test_without_building: true,
      test_type.to_sym => test_file
    )
    
    # Collect test results
    test_result_bundle = Dir["/Users/runner/Library/Developer/Xcode/DerivedData/**/Logs/Test/*.xcresult"].last
    if test_result_bundle
      puts "Test results available at: #{test_result_bundle}"
      xcparse_output = sh("xcparse result #{test_result_bundle}")
      puts xcparse_output
    else
      UI.error("No test result bundle found")
    end
  end
end