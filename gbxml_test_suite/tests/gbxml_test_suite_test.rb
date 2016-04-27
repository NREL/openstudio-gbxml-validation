require 'openstudio'
require 'openstudio/ruleset/ShowRunnerOutput'
require 'minitest/autorun'
require_relative '../measure.rb'
require 'fileutils'

class GBXMLTestSuiteTest < MiniTest::Unit::TestCase

  # def setup
  # end

  # def teardown
  # end

  

  def test_case1
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 1"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_1/test_case_1.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_1/test_case_1.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
  
  def test_case2
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 2"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_2/test_case_2.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_2/test_case_2.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
  
  def test_case3
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 3"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_3/test_case_3.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_3/test_case_3.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
  
  def test_case5
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 5"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_5/test_case_5.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_5/test_case_5.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
  
  def test_case6
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 6"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_6/test_case_6.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_6/test_case_6.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
  
  def test_case7
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 7"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_7/test_case_7.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_7/test_case_7.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
  
  def test_case8
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 8"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_8/test_case_8.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_8/test_case_8.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end

  def test_case12
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Test Case 12"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_12/test_case_12.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_12/test_case_12.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
  
  def test_caseWBT1
    # create an instance of the measure
    measure = GBXMLTestSuite.new

    # create an instance of a runner
    runner = OpenStudio::Ruleset::OSRunner.new

    # load the test model
    model = OpenStudio::Model::Model.new

    # get arguments
    arguments = measure.arguments(model)
    argument_map = OpenStudio::Ruleset.convertOSArgumentVectorToMap(arguments)

    # create hash of argument values.
    # If the argument has a default that you want to use, you don't need it in the hash
    args_hash = {}
    args_hash["testcases"] = "Whole Building Test Case 1"
    # using defaults values from measure.rb for other arguments

    # populate argument with specified hash value if specified
    arguments.each do |arg|
      temp_arg_var = arg.clone
      if args_hash[arg.name]
        assert(temp_arg_var.setValue(args_hash[arg.name]))
      end
      argument_map[arg.name] = temp_arg_var
    end

    # run the measure
    measure.run(model, runner, argument_map)
    result = runner.result

    # show the output
    show_output(result)

    # assert that it ran correctly
    assert_equal("Success", result.value.valueName)

    # save the model to test output directory
    output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_wbt1/test_case_wbt1.osm")
    model.save(output_file_path,true)
	
	#save model as gbxml
	forwardTranslator = OpenStudio::GbXML::GbXMLForwardTranslator.new 
	output_file_path = OpenStudio::Path.new(File.dirname(__FILE__) + "/output/test_case_wbt1/test_case_wbt1.xml")
    forwardTranslator.modelToGbXML(model, output_file_path);
  end
end
