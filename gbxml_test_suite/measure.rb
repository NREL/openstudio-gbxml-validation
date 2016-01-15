# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/measures/measure_writing_guide/

# start the measure
class GBXMLTestSuite < OpenStudio::Ruleset::ModelUserScript

  # human readable name
  def name
    return "GBXML Test Suite"
  end

  # human readable description
  def description
    return "A measure to build all of the GBXML Validation Test Cases.  A number is the only property that needs to be provided."
  end

  # human readable description of modeling approach
  def modeler_description
    return "TBD"
  end

  # define the arguments that the user will input
  def arguments(model)
    args = OpenStudio::Ruleset::OSArgumentVector.new

    # the name of the space to add to the model
    chs = OpenStudio::StringVector.new
    chs << "Test Case 1"
    chs << "Test Case 2"
	chs << "Test Case 3"
	chs << "Test Case 4"
	chs << "Test Case 5"
    testcases = OpenStudio::Ruleset::OSArgument::makeChoiceArgument('testcases', chs, true)
	testcases.setDisplayName("gbXML Validation Test Case Number")
	testcases.setDescription("Select a test case based upon gbXML validator test cases.  Refer to gbxml.org for more information.")
	args << testcases

    return args
  end

  # define what happens when the measure is run
  def run(model, runner, user_arguments)
    make_zones = true
	surface_matching = true
	
    ft_to_m = 0.3048
    super(model, runner, user_arguments)

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(model), user_arguments)
      return false
    end

    # assign the user inputs to variables
    test_case = runner.getStringArgumentValue("testcases", user_arguments)

	#add a switch statement based upon the test case number
	case test_case
	  when "Test Case 1"
	    #stuff here
		
		runner.registerInfo("Starting Test Case 1")
		facility = model.getFacility
		building = model.getBuilding
		level1 = OpenStudio::Model::BuildingStory.new(model)
        level1.setNominalFloortoFloorHeight(0)
        level1.setName("Level 1")
		level1p = OpenStudio::Model::BuildingStory.new(model)
        level1p.setNominalFloortoFloorHeight(10*ft_to_m)
        level1p.setName("Level 1 Plenum")
		level2 = OpenStudio::Model::BuildingStory.new(model)
        level2.setNominalFloortoFloorHeight(13*ft_to_m)
        level2.setName("Level 2")
		level2p = OpenStudio::Model::BuildingStory.new(model)
        level2p.setNominalFloortoFloorHeight(23*ft_to_m)
        level2p.setName("Level 2 Plenum")
		level3 = OpenStudio::Model::BuildingStory.new(model)
        level3.setNominalFloortoFloorHeight(26*ft_to_m)
        level3.setName("Level 3")
		

		#create a vector of points and pass these to a surface
		swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,0)
		sepoint = OpenStudio::Point3d.new(0,0,0)
		nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,0)
		nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,0)
		sp1polygon = OpenStudio::Point3dVector.new
		sp1polygon << swpoint
		sp1polygon << nwpoint
		sp1polygon << nepoint
		sp1polygon << sepoint
		height = 10*ft_to_m
		sp1 = OpenStudio::Model::Space::fromFloorPrint(sp1polygon, height, model)
		sp1 = sp1.get
		sp1.setName("sp-1-Space")
		sp1.setBuildingStory(level1)
		
		swpoint = OpenStudio::Point3d.new(0,0,0)
		sepoint = OpenStudio::Point3d.new(8*ft_to_m,0,0)
		nepoint = OpenStudio::Point3d.new(8*ft_to_m,20*ft_to_m,0)
		nwpoint = OpenStudio::Point3d.new(0,20*ft_to_m,0)
		sp2polygon = OpenStudio::Point3dVector.new
		sp2polygon << swpoint
		sp2polygon << nwpoint
		sp2polygon << nepoint
		sp2polygon << sepoint
		height = 26*ft_to_m
		sp2 = OpenStudio::Model::Space::fromFloorPrint(sp2polygon, height, model)
		sp2 = sp2.get
		sp2.setName("sp-2-Space")
		sp2.setBuildingStory(level1)
		
		swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,13*ft_to_m)
		sepoint = OpenStudio::Point3d.new(0,0,13*ft_to_m)
		nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,13*ft_to_m)
		nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,13*ft_to_m)
		sp3polygon = OpenStudio::Point3dVector.new
		sp3polygon << swpoint
		sp3polygon << nwpoint
		sp3polygon << nepoint
		sp3polygon << sepoint
		height = 13*ft_to_m
		sp3 = OpenStudio::Model::Space::fromFloorPrint(sp3polygon, height, model)
		sp3 = sp3.get
		sp3.setName("sp-3-Space")
		sp3.setBuildingStory(level2)
		
		swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,10*ft_to_m)
		sepoint = OpenStudio::Point3d.new(0,0,10*ft_to_m)
		nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m)
		nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,10*ft_to_m)
		sp4polygon = OpenStudio::Point3dVector.new
		sp4polygon << swpoint
		sp4polygon << nwpoint
		sp4polygon << nepoint
		sp4polygon << sepoint
		height = 3*ft_to_m
		sp4 = OpenStudio::Model::Space::fromFloorPrint(sp4polygon, height, model)
		sp4 = sp4.get
		sp4.setName("sp-4-Space")
		sp4.setBuildingStory(level1p)
		
		#put all of the spaces in the model into a vector
		spaces = OpenStudio::Model::SpaceVector.new
		model.getSpaces.each do |space|
		  spaces << space
		  if make_zones
			#create zones
			new_zone = OpenStudio::Model::ThermalZone.new(model)
			space.setThermalZone(new_zone)
			zone_name = space.name.get.gsub("Space","Zone")
			new_zone.setName(zone_name)
		  end
		end

		if surface_matching
		  #match surfaces for each space in the vector
		  OpenStudio::Model.matchSurfaces(spaces)
		  OpenStudio::Model.intersectSurfaces(spaces)
		end
		
		finishing_spaces = model.getSpaces
		runner.registerFinalCondition("The building finished with #{finishing_spaces.size} spaces.")
	  when "Test Case 2"
        #stuff here
		runner.registerInfo("Starting Test Case 2")
		facility = model.getFacility
		building = model.getBuilding
		level1 = OpenStudio::Model::BuildingStory.new(model)
		level1.setNominalFloortoFloorHeight(0)
		level1.setName("Level 1")
		level2 = OpenStudio::Model::BuildingStory.new(model)
		level2.setNominalFloortoFloorHeight(13*ft_to_m)
		level2.setName("Level 2")
		shades = OpenStudio::Model::ShadingSurfaceGroup.new(model)
		
		
		sp1 = OpenStudio::Model::Space.new(model)
		sp1.setBuildingStory(level1)
		sp1.setBuildingStory(level2)
		sp1.setName("sp-1-Space")
		swpoint = OpenStudio::Point3d.new(0,0,0)
		sepoint = OpenStudio::Point3d.new(30*ft_to_m,0,0)
		nepoint = OpenStudio::Point3d.new(30*ft_to_m,30*ft_to_m,0)
		nwpoint = OpenStudio::Point3d.new(0,30*ft_to_m,0)
		flpolygon = OpenStudio::Point3dVector.new
		flpolygon << swpoint
		flpolygon << nwpoint
		flpolygon << nepoint
		flpolygon << sepoint
		floor = OpenStudio::Model::Surface.new(flpolygon,model)
		floor.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(0,0,0)
		point2 = OpenStudio::Point3d.new(0,0,13*ft_to_m)
		point3 = OpenStudio::Point3d.new(0,30*ft_to_m,13*ft_to_m)
		point4 = OpenStudio::Point3d.new(0,30*ft_to_m,0)
		wpolygon = OpenStudio::Point3dVector.new
		wpolygon << point1
		wpolygon << point2
		wpolygon << point3
		wpolygon << point4
		w_wall = OpenStudio::Model::Surface.new(wpolygon,model)
		w_wall.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(0,24.6875*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(0,21.6875*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(0,21.6875*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(0,24.6875*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		wwindow1 = OpenStudio::Model::SubSurface.new(spolygon,model)
		wwindow1.setSurface(w_wall)
		
		point1 = OpenStudio::Point3d.new(0,16.5*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(0,13.5*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(0,13.5*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(0,16.5*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		wwindow2 = OpenStudio::Model::SubSurface.new(spolygon,model)
		wwindow2.setSurface(w_wall)
		
		point1 = OpenStudio::Point3d.new(0,8.3125*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(0,5.3125*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(0,5.3125*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(0,8.3125*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		wwindow3 = OpenStudio::Model::SubSurface.new(spolygon,model)
		wwindow3.setSurface(w_wall)
		
		swpoint = OpenStudio::Point3d.new(0,0,13*ft_to_m)
		sepoint = OpenStudio::Point3d.new(30*ft_to_m,0,13*ft_to_m)
		nepoint = OpenStudio::Point3d.new(30*ft_to_m,30*ft_to_m,13*ft_to_m)
		nwpoint = OpenStudio::Point3d.new(0,30*ft_to_m,13*ft_to_m)
		cpolygon = OpenStudio::Point3dVector.new
		cpolygon << swpoint
		cpolygon << sepoint
		cpolygon << nepoint
		cpolygon << nwpoint
		ceil = OpenStudio::Model::Surface.new(cpolygon,model)
		ceil.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(0,30*ft_to_m,0)
		point2 = OpenStudio::Point3d.new(0,30*ft_to_m,13*ft_to_m)
		point3 = OpenStudio::Point3d.new(30*ft_to_m,30*ft_to_m,13*ft_to_m)
		point4 = OpenStudio::Point3d.new(30*ft_to_m,30*ft_to_m,0)
		npolygon = OpenStudio::Point3dVector.new
		npolygon << point1
		npolygon << point2
		npolygon << point3
		npolygon << point4
		n_wall = OpenStudio::Model::Surface.new(npolygon,model)
		n_wall.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(24.71875*ft_to_m,30*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(21.71875*ft_to_m,30*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(21.71875*ft_to_m,30*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(24.71875*ft_to_m,30*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		nwindow1 = OpenStudio::Model::SubSurface.new(spolygon,model)
		nwindow1.setSurface(n_wall)
		
		point1 = OpenStudio::Point3d.new(16.5625*ft_to_m,30*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(13.5625*ft_to_m,30*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(13.5625*ft_to_m,30*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(16.5625*ft_to_m,30*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		nwindow2 = OpenStudio::Model::SubSurface.new(spolygon,model)
		nwindow2.setSurface(n_wall)
		
		point1 = OpenStudio::Point3d.new(8.40625*ft_to_m,30*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(5.40625*ft_to_m,30*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(5.40625*ft_to_m,30*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(8.40625*ft_to_m,30*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		nwindow3 = OpenStudio::Model::SubSurface.new(spolygon,model)
		nwindow3.setSurface(n_wall)
		
		point1 = OpenStudio::Point3d.new(30*ft_to_m,30*ft_to_m,0)
		point2 = OpenStudio::Point3d.new(30*ft_to_m,30*ft_to_m,13*ft_to_m)
		point3 = OpenStudio::Point3d.new(30*ft_to_m,0,13*ft_to_m)
		point4 = OpenStudio::Point3d.new(30*ft_to_m,0,0)
		epolygon = OpenStudio::Point3dVector.new
		epolygon << point1
		epolygon << point2
		epolygon << point3
		epolygon << point4
		e_wall = OpenStudio::Model::Surface.new(epolygon,model)
		e_wall.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(30*ft_to_m,5.354167*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(30*ft_to_m,8.354167*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(30*ft_to_m,8.354167*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(30*ft_to_m,5.354167*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		ewindow1 = OpenStudio::Model::SubSurface.new(spolygon,model)
		ewindow1.setSurface(e_wall)
		
		point1 = OpenStudio::Point3d.new(30*ft_to_m,13.5*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(30*ft_to_m,16.5*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(30*ft_to_m,16.5*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(30*ft_to_m,13.5*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		ewindow2 = OpenStudio::Model::SubSurface.new(spolygon,model)
		ewindow2.setSurface(e_wall)
		
		point1 = OpenStudio::Point3d.new(30*ft_to_m,21.6875*ft_to_m,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(30*ft_to_m,24.6875*ft_to_m,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(30*ft_to_m,24.6875*ft_to_m,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(30*ft_to_m,21.6875*ft_to_m,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		ewindow3 = OpenStudio::Model::SubSurface.new(spolygon,model)
		ewindow3.setSurface(e_wall)
		
		point1 = OpenStudio::Point3d.new(30*ft_to_m,0,0)
		point2 = OpenStudio::Point3d.new(30*ft_to_m,0,13*ft_to_m)
		point3 = OpenStudio::Point3d.new(0,0,13*ft_to_m)
		point4 = OpenStudio::Point3d.new(0,0,0)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		s_wall = OpenStudio::Model::Surface.new(spolygon,model)
		s_wall.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(5.46875*ft_to_m,0,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(8.46875*ft_to_m,0,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(8.46875*ft_to_m,0,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(5.46875*ft_to_m,0,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		swindow1 = OpenStudio::Model::SubSurface.new(spolygon,model)
		swindow1.setSurface(s_wall)
		
		shadep1 = OpenStudio::Point3d.new(5.46875*ft_to_m,0,4.9167*ft_to_m)
		shadep2 = OpenStudio::Point3d.new(5.46875*ft_to_m,-1.5*ft_to_m,4.9167*ft_to_m)
		shadep3 = OpenStudio::Point3d.new(8.46875*ft_to_m,-1.5*ft_to_m,4.9167*ft_to_m)
		shadep4 = OpenStudio::Point3d.new(8.46875*ft_to_m,0,4.9167*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << shadep1
		spolygon << shadep2
		spolygon << shadep3
		spolygon << shadep4
		shade1 = OpenStudio::Model::ShadingSurface.new(spolygon,model)
		shade1.setShadingSurfaceGroup(shades)
		
		point1 = OpenStudio::Point3d.new(13.625*ft_to_m,0,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(16.625*ft_to_m,0,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(16.625*ft_to_m,0,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(13.625*ft_to_m,0,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		swindow2 = OpenStudio::Model::SubSurface.new(spolygon,model)
		swindow2.setSurface(s_wall)
		
		point1 = OpenStudio::Point3d.new(21.71875*ft_to_m,0,3*ft_to_m)
		point2 = OpenStudio::Point3d.new(24.71875*ft_to_m,0,3*ft_to_m)
		point3 = OpenStudio::Point3d.new(24.71875*ft_to_m,0,7*ft_to_m)
		point4 = OpenStudio::Point3d.new(21.71875*ft_to_m,0,7*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		swindow3 = OpenStudio::Model::SubSurface.new(spolygon,model)
		swindow3.setSurface(s_wall)
		
		#put all of the spaces in the model into a vector
		spaces = OpenStudio::Model::SpaceVector.new
		model.getSpaces.each do |space|
		  spaces << space
		  if make_zones
			#create zones
			new_zone = OpenStudio::Model::ThermalZone.new(model)
			space.setThermalZone(new_zone)
			zone_name = space.name.get.gsub("Space","Zone")
			new_zone.setName(zone_name)
		  end
		end

		if surface_matching
		  #match surfaces for each space in the vector
		  OpenStudio::Model.matchSurfaces(spaces)
		  OpenStudio::Model.intersectSurfaces(spaces)
		end
		
		finishing_spaces = model.getSpaces
		runner.registerFinalCondition("The building finished with #{finishing_spaces.size} spaces.")
      when "Test Case 3"
	    runner.registerInfo("Starting Test Case 5")
		facility = model.getFacility
		building = model.getBuilding
		level1 = OpenStudio::Model::BuildingStory.new(model)
        level1.setNominalFloortoFloorHeight(0)
        level1.setName("Level 1")
		level2 = OpenStudio::Model::BuildingStory.new(model)
        level2.setNominalFloortoFloorHeight(13*ft_to_m)
        level2.setName("Level 2")	
		level3 = OpenStudio::Model::BuildingStory.new(model)
        level3.setNominalFloortoFloorHeight(26*ft_to_m)
        level3.setName("Level 3")	
		
		#create a vector of points and pass these to a surface
		swpoint = OpenStudio::Point3d.new(-40*ft_to_m,0,0)
		sepoint = OpenStudio::Point3d.new(0,0,0)
		nepoint = OpenStudio::Point3d.new(0,15*ft_to_m,0)
		nwpoint = OpenStudio::Point3d.new(-40*ft_to_m,15*ft_to_m,0)
		sp1polygon = OpenStudio::Point3dVector.new
		sp1polygon << swpoint
		sp1polygon << nwpoint
		sp1polygon << nepoint
		sp1polygon << sepoint
		height = 13*ft_to_m
		sp1 = OpenStudio::Model::Space::fromFloorPrint(sp1polygon, height, model)
		sp1 = sp1.get
		sp1.setName("sp-2-Space")
		sp1.setBuildingStory(level1)
		
		swpoint = OpenStudio::Point3d.new(-40*ft_to_m,15*ft_to_m,0)
		sepoint = OpenStudio::Point3d.new(0,15*ft_to_m,0)
		nepoint = OpenStudio::Point3d.new(0,50*ft_to_m,0)
		nwpoint = OpenStudio::Point3d.new(-40*ft_to_m,50*ft_to_m,0)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << swpoint
		spolygon << nwpoint
		spolygon << nepoint
		spolygon << sepoint
		height = 13*ft_to_m
		sp2 = OpenStudio::Model::Space::fromFloorPrint(spolygon, height, model)
		sp2 = sp2.get
		sp2.setName("sp-3-Space")
		sp2.setBuildingStory(level1)
		
		swpoint = OpenStudio::Point3d.new(0,0,0)
		sepoint = OpenStudio::Point3d.new(50*ft_to_m,0,0)
		nepoint = OpenStudio::Point3d.new(50*ft_to_m,50*ft_to_m,0)
		nwpoint = OpenStudio::Point3d.new(0,50*ft_to_m,0)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << swpoint
		spolygon << nwpoint
		spolygon << nepoint
		spolygon << sepoint
		height = 26*ft_to_m
		sp3 = OpenStudio::Model::Space::fromFloorPrint(spolygon, height, model)
		sp3 = sp3.get
		sp3.setName("sp-4-Space")
		sp3.setBuildingStory(level1)
		
		swpoint = OpenStudio::Point3d.new(-40*ft_to_m,0,13*ft_to_m)
		sepoint = OpenStudio::Point3d.new(0,0,13*ft_to_m)
		nepoint = OpenStudio::Point3d.new(0,35*ft_to_m,13*ft_to_m)
		nwpoint = OpenStudio::Point3d.new(-40*ft_to_m,35*ft_to_m,13*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << swpoint
		spolygon << nwpoint
		spolygon << nepoint
		spolygon << sepoint
		height = 13*ft_to_m
		sp4 = OpenStudio::Model::Space::fromFloorPrint(spolygon, height, model)
		sp4 = sp4.get
		sp4.setName("sp-5-Space")
		sp4.setBuildingStory(level2)
		
		swpoint = OpenStudio::Point3d.new(-40*ft_to_m,35*ft_to_m,13*ft_to_m)
		sepoint = OpenStudio::Point3d.new(0,35*ft_to_m,13*ft_to_m)
		nepoint = OpenStudio::Point3d.new(0,50*ft_to_m,13*ft_to_m)
		nwpoint = OpenStudio::Point3d.new(-40*ft_to_m,50*ft_to_m,13*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << swpoint
		spolygon << nwpoint
		spolygon << nepoint
		spolygon << sepoint
		height = 13*ft_to_m
		sp5 = OpenStudio::Model::Space::fromFloorPrint(spolygon, height, model)
		sp5 = sp5.get
		sp5.setName("sp-6-Space")
		sp5.setBuildingStory(level2)
		
		#put all of the spaces in the model into a vector
		spaces = OpenStudio::Model::SpaceVector.new
		model.getSpaces.each do |space|
		  spaces << space
		  if make_zones
			#create zones
			new_zone = OpenStudio::Model::ThermalZone.new(model)
			space.setThermalZone(new_zone)
			zone_name = space.name.get.gsub("Space","Zone")
			new_zone.setName(zone_name)
		  end
		end

		if surface_matching
		  #match surfaces for each space in the vector
		  OpenStudio::Model.matchSurfaces(spaces)
		  OpenStudio::Model.intersectSurfaces(spaces)
		end
		
		finishing_spaces = model.getSpaces
		runner.registerFinalCondition("The building finished with #{finishing_spaces.size} spaces.")
		
	  when "Test Case 5"
        runner.registerInfo("Starting Test Case 5")
		facility = model.getFacility
		building = model.getBuilding
		levelb1 = OpenStudio::Model::BuildingStory.new(model)
        levelb1.setNominalFloortoFloorHeight(-12*ft_to_m)
        levelb1.setName("Level B1")
		level1 = OpenStudio::Model::BuildingStory.new(model)
        level1.setNominalFloortoFloorHeight(0)
        level1.setName("Level 1")
		level2 = OpenStudio::Model::BuildingStory.new(model)
        level2.setNominalFloortoFloorHeight(10*ft_to_m)
        level2.setName("Level 2")	 

        sp1 = OpenStudio::Model::Space.new(model)
		sp1.setBuildingStory(levelb1)
		sp1.setName("sp-1-Space")
		swpoint = OpenStudio::Point3d.new(0,0,-12*ft_to_m)
		sepoint = OpenStudio::Point3d.new(21.5*ft_to_m,0,-12*ft_to_m)
		nepoint = OpenStudio::Point3d.new(21.5*ft_to_m,27.5*ft_to_m,-12*ft_to_m)
		nwpoint = OpenStudio::Point3d.new(0,27.5*ft_to_m,-12*ft_to_m)
		flpolygon = OpenStudio::Point3dVector.new
		flpolygon << swpoint
		flpolygon << nwpoint
		flpolygon << nepoint
		flpolygon << sepoint
		floor = OpenStudio::Model::Surface.new(flpolygon,model)
		floor.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(0,0,-12*ft_to_m)
		point2 = OpenStudio::Point3d.new(0,0,0)
		point3 = OpenStudio::Point3d.new(0,27.5*ft_to_m,0)
		point4 = OpenStudio::Point3d.new(0,27.5*ft_to_m,-12*ft_to_m)
		wpolygon = OpenStudio::Point3dVector.new
		wpolygon << point1
		wpolygon << point2
		wpolygon << point3
		wpolygon << point4
		wbasement = OpenStudio::Model::Surface.new(wpolygon,model)
		wbasement.setSpace(sp1)
		
		swpoint = OpenStudio::Point3d.new(0,0,0)
		sepoint = OpenStudio::Point3d.new(21.5*ft_to_m,0,0)
		nepoint = OpenStudio::Point3d.new(21.5*ft_to_m,27.5*ft_to_m,0)
		nwpoint = OpenStudio::Point3d.new(0,27.5*ft_to_m,0)
		cpolygon = OpenStudio::Point3dVector.new
		cpolygon << swpoint
		cpolygon << sepoint
		cpolygon << nepoint
		cpolygon << nwpoint
		ceil = OpenStudio::Model::Surface.new(cpolygon,model)
		ceil.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(0,27.5*ft_to_m,-12*ft_to_m)
		point2 = OpenStudio::Point3d.new(0,27.5*ft_to_m,0)
		point3 = OpenStudio::Point3d.new(21.5*ft_to_m,27.5*ft_to_m,0)
		point4 = OpenStudio::Point3d.new(21.5*ft_to_m,27.5*ft_to_m,-12*ft_to_m)
		npolygon = OpenStudio::Point3dVector.new
		npolygon << point1
		npolygon << point2
		npolygon << point3
		npolygon << point4
		nbasement = OpenStudio::Model::Surface.new(npolygon,model)
		nbasement.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(21.5*ft_to_m,27.5*ft_to_m,-12*ft_to_m)
		point2 = OpenStudio::Point3d.new(21.5*ft_to_m,27.5*ft_to_m,0)
		point3 = OpenStudio::Point3d.new(21.5*ft_to_m,0,0)
		point4 = OpenStudio::Point3d.new(21.5*ft_to_m,0,-12*ft_to_m)
		epolygon = OpenStudio::Point3dVector.new
		epolygon << point1
		epolygon << point2
		epolygon << point3
		epolygon << point4
		ebasement = OpenStudio::Model::Surface.new(epolygon,model)
		ebasement.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(21.5*ft_to_m,0,-12*ft_to_m)
		point2 = OpenStudio::Point3d.new(21.5*ft_to_m,0,0)
		point3 = OpenStudio::Point3d.new(0,0,0)
		point4 = OpenStudio::Point3d.new(0,0,-12*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		sbasement = OpenStudio::Model::Surface.new(spolygon,model)
		sbasement.setSpace(sp1)
		
		point1 = OpenStudio::Point3d.new(21*ft_to_m,0,-11.5*ft_to_m)
		point2 = OpenStudio::Point3d.new(21*ft_to_m,0,-0.5)
		point3 = OpenStudio::Point3d.new(0.5,0,-0.5)
		point4 = OpenStudio::Point3d.new(0.5,0,-11.5*ft_to_m)
		spolygon = OpenStudio::Point3dVector.new
		spolygon << point1
		spolygon << point2
		spolygon << point3
		spolygon << point4
		swindow = OpenStudio::Model::SubSurface.new(spolygon,model)
		swindow.setSurface(sbasement)
		
		#put all of the spaces in the model into a vector
		spaces = OpenStudio::Model::SpaceVector.new
		model.getSpaces.each do |space|
		  spaces << space
		  if make_zones
			#create zones
			new_zone = OpenStudio::Model::ThermalZone.new(model)
			space.setThermalZone(new_zone)
			zone_name = space.name.get.gsub("Space","Zone")
			new_zone.setName(zone_name)
		  end
		end

		if surface_matching
		  #match surfaces for each space in the vector
		  OpenStudio::Model.matchSurfaces(spaces)
		  OpenStudio::Model.intersectSurfaces(spaces)
		end
		
		finishing_spaces = model.getSpaces
		runner.registerFinalCondition("The building finished with #{finishing_spaces.size} spaces.")
	  else
        #error here, return false
		runner.registerError("Test case '#{test_case}' is not defined.")
		return false
     end		


    return true

  end
  
end

# register the measure to be used by the application
GBXMLTestSuite.new.registerWithApplication
