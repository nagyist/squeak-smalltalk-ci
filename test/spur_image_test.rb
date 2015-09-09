require_relative 'test_helper'
require 'fileutils'
require 'rspec'

describe "Trunk test suite for Spur" do
  RUN_TEST_IMAGE_NAME = "SpurPostTestTrunkImage"

  before :all do
    @os_name = identify_os
    assert_cog_spur_vm(@os_name)

    Dir.chdir(TARGET_DIR) {
      # Copy the clean image so we can run the tests without touching the artifact.
      FileUtils.cp("#{SPUR_TRUNK_IMAGE}.image", "#{SRC}/target/#{RUN_TEST_IMAGE_NAME}.image")
      FileUtils.cp("#{SPUR_TRUNK_IMAGE}.changes", "#{SRC}/target/#{RUN_TEST_IMAGE_NAME}.changes")
    }
  end

  after :all do
    ["#{RUN_TEST_IMAGE_NAME}.image", "#{RUN_TEST_IMAGE_NAME}.changes"].each { |f|
      FileUtils.rm(f) if File.exists?(f)
    }
  end

  context "image test suite" do
    it "should pass all tests", :spur => true do
      Dir.chdir("#{SRC}/target") {
        log("VM: #{@vm}")
        run_cmd("#{@vm} -version")
        args = vm_args(@os_name)
        args << "-reportheadroom"
        run_image_with_cmd(@vm, vm_args(@os_name), RUN_TEST_IMAGE_NAME, "#{SRC}/tests.st", 30.minutes)
      }
    end
  end
end
