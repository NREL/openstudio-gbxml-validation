# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/measures/measure_writing_guide/

def sort_spaces(spaces)
  temp_spaces = spaces.sort{|x,y| x.floorArea <=> y.floorArea}
  
  result = OpenStudio::Model::SpaceVector.new
  temp_spaces.each do |temp_space|
    result << temp_space
  end
  
  return result
end

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
    chs << "Test Case 6"
    chs << "Test Case 7"
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
		
      sp1 = OpenStudio::Model::Space.new(model)
      sp1.setBuildingStory(level1)
      sp1.setName("sp-1-Space")
		
      sp4 = OpenStudio::Model::Space.new(model)
      sp4.setBuildingStory(level1p)
      sp4.setName("sp-4-Space")
		
      sp3 = OpenStudio::Model::Space.new(model)
      sp3.setBuildingStory(level2)
      sp3.setName("sp-3-Space")
		
      sp2 = OpenStudio::Model::Space.new(model)
      sp2.setBuildingStory(level1)
      sp2.setName("sp-2-Space")
		
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
      fl1 = OpenStudio::Model::Surface.new(sp1polygon,model)
      fl1.setSpace(sp1)

      swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,0)
      swpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,0,10*ft_to_m)
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,10*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,0)
      sp1w = OpenStudio::Point3dVector.new
      sp1w << swpoint
      sp1w << swpoint2
      sp1w << nwpoint2
      sp1w << nwpoint
      sp1West = OpenStudio::Model::Surface.new(sp1w,model)
      sp1West.setSpace(sp1)
		
      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,0)
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,10*ft_to_m)
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m)
      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,0)
      sp1n = OpenStudio::Point3dVector.new
      sp1n << nwpoint
      sp1n << nwpoint2
      sp1n << nepoint2
      sp1n << nepoint
      sp1North = OpenStudio::Model::Surface.new(sp1n,model)
      sp1North.setSpace(sp1)

      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,0)
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m)
      sepoint2 = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      sepoint = OpenStudio::Point3d.new(0,0,0)
      sp1e = OpenStudio::Point3dVector.new
      sp1e << nepoint
      sp1e << nepoint2
      sp1e << sepoint2
      sp1e << sepoint
      sp1East = OpenStudio::Model::Surface.new(sp1e,model)
      sp1East.setSpace(sp1)

      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,10*ft_to_m) 
      swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,10*ft_to_m) 
      sepoint = OpenStudio::Point3d.new(0,0,10*ft_to_m) 
      sp1ceil = OpenStudio::Point3dVector.new
      sp1ceil << nepoint
      sp1ceil << nwpoint
      sp1ceil << swpoint
      sp1ceil << sepoint
      sp1Ceil = OpenStudio::Model::Surface.new(sp1ceil,model)
      sp1Ceil.setSpace(sp1)

      #space-4
      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,10*ft_to_m) 
      swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,10*ft_to_m) 
      sepoint = OpenStudio::Point3d.new(0,0,10*ft_to_m) 
      sp4fl = OpenStudio::Point3dVector.new
      sp4fl << sepoint
      sp4fl << swpoint
      sp4fl << nwpoint
      sp4fl << nepoint
      sp4Floor = OpenStudio::Model::Surface.new(sp4fl,model)
      sp4Floor.setSpace(sp4)
      sp4Floor.setAdjacentSurface(sp1Ceil)

      swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,10*ft_to_m) 
      swpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,0,13*ft_to_m) 
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,13*ft_to_m) 
      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,10*ft_to_m) 
      sp4w = OpenStudio::Point3dVector.new
      sp4w << swpoint
      sp4w << swpoint2
      sp4w << nwpoint2
      sp4w << nwpoint
      sp4West = OpenStudio::Model::Surface.new(sp4w,model)
      sp4West.setSpace(sp4)

      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,10*ft_to_m) 
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,13*ft_to_m) 
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,13*ft_to_m) 
      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m) 
      sp4n = OpenStudio::Point3dVector.new
      sp4n << nwpoint
      sp4n << nwpoint2
      sp4n << nepoint2
      sp4n << nepoint
      sp4North = OpenStudio::Model::Surface.new(sp4n,model)
      sp4North.setSpace(sp4)

      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m)
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,13*ft_to_m) 
      sepoint2 = OpenStudio::Point3d.new(0,0,13*ft_to_m)  
      sepoint = OpenStudio::Point3d.new(0,0,10*ft_to_m)  
      sp4e = OpenStudio::Point3dVector.new
      sp4e << nepoint
      sp4e << nepoint2
      sp4e << sepoint2
      sp4e << sepoint
      sp4East = OpenStudio::Model::Surface.new(sp4e,model)
      sp4East.setSpace(sp4)

      sepoint2 = OpenStudio::Point3d.new(0,0,13*ft_to_m) 
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,13*ft_to_m) 
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,13*ft_to_m)  
      swpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,0,13*ft_to_m)  
      sp4ceil = OpenStudio::Point3dVector.new
      sp4ceil << sepoint2
      sp4ceil << nepoint2
      sp4ceil << nwpoint2
      sp4ceil << swpoint2
      sp4Ceil = OpenStudio::Model::Surface.new(sp4ceil,model)
      sp4Ceil.setSpace(sp4)

      #space3
      sp3fl = OpenStudio::Point3dVector.new
      sp3fl << swpoint2
      sp3fl << nwpoint2
      sp3fl << nepoint2
      sp3fl << sepoint2
      sp3Floor = OpenStudio::Model::Surface.new(sp3fl,model)
      sp3Floor.setSpace(sp3)
      sp3Floor.setAdjacentSurface(sp4Ceil)
		
      swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,13*ft_to_m)  
      swpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,0,26*ft_to_m)
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,26*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,13*ft_to_m)
      sp3w = OpenStudio::Point3dVector.new
      sp3w << swpoint
      sp3w << swpoint2
      sp3w << nepoint2
      sp3w << nepoint
      sp3West = OpenStudio::Model::Surface.new(sp3w,model)
      sp3West.setSpace(sp3)
      
      nwpoint = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,13*ft_to_m)
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,26*ft_to_m)
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,26*ft_to_m)
      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,13*ft_to_m)
      sp3n = OpenStudio::Point3dVector.new
      sp3n << nwpoint
      sp3n << nwpoint2
      sp3n << nepoint2
      sp3n << nepoint
      sp3North = OpenStudio::Model::Surface.new(sp3n,model)
      sp3North.setSpace(sp3)
		
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,26*ft_to_m)
      nwpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,20*ft_to_m,26*ft_to_m)
      swpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,0,26*ft_to_m)
      sepoint2 = OpenStudio::Point3d.new(0,0,26*ft_to_m)
      sp3c = OpenStudio::Point3dVector.new
      sp3c << nepoint2
      sp3c << nwpoint2
      sp3c << swpoint2
      sp3c << sepoint2
      sp3Ceil = OpenStudio::Model::Surface.new(sp3c,model)
      sp3Ceil.setSpace(sp3)
      
      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,13*ft_to_m)
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,26*ft_to_m)
      sepoint2 = OpenStudio::Point3d.new(0,0,26*ft_to_m)
      sepoint = OpenStudio::Point3d.new(0,0,13*ft_to_m)
      sp3e = OpenStudio::Point3dVector.new
      sp3e <<nepoint
      sp3e << nepoint2
      sp3e << sepoint2
      sp3e << sepoint
      sp3East = OpenStudio::Model::Surface.new(sp3e,model)
      sp3East.setSpace(sp3)
		
      sepoint = OpenStudio::Point3d.new(0,0,13*ft_to_m)
      sepoint2 = OpenStudio::Point3d.new(0,0,26*ft_to_m)
      swpoint2 = OpenStudio::Point3d.new(-36*ft_to_m,0,26*ft_to_m)
      swpoint = OpenStudio::Point3d.new(-36*ft_to_m,0,13*ft_to_m)
      sp3s = OpenStudio::Point3dVector.new
      sp3s << sepoint
      sp3s << sepoint2
      sp3s << swpoint2
      sp3s << swpoint
      sp3South = OpenStudio::Model::Surface.new(sp3s,model)
      sp3South.setSpace(sp3)
      
      #space 2
      sepoint = OpenStudio::Point3d.new(0,0,0)
      sepoint2 = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      nepoint2 = OpenStudio::Point3d.new(0,20*ft_to_m,10*ft_to_m)
      nepoint = OpenStudio::Point3d.new(0,20*ft_to_m,0)
      
      sp2w1 = OpenStudio::Point3dVector.new
      sp2w1 << sepoint2
      sp2w1 << sepoint
      sp2w1 << nepoint
      sp2w1 << nepoint2
      sp2West1 = OpenStudio::Model::Surface.new(sp2w1,model)
      sp2West1.setSpace(sp2)
          sp2West1.setAdjacentSurface(sp1East)
      
      swpoint = OpenStudio::Point3d.new(0,0.25*ft_to_m,0)
      sepoint = OpenStudio::Point3d.new(8*ft_to_m,0.25*ft_to_m,0)
      sepoint2 = OpenStudio::Point3d.new(8*ft_to_m,0.25*ft_to_m,26*ft_to_m)
      swpoint2 = OpenStudio::Point3d.new(0,0.25*ft_to_m,26*ft_to_m)
      sp2s = OpenStudio::Point3dVector.new
      sp2s << swpoint
      sp2s << sepoint
      sp2s << sepoint2
      sp2s << swpoint2
      sp2South = OpenStudio::Model::Surface.new(sp2s,model)
      sp2South.setSpace(sp2)
      
      sepoint2 = OpenStudio::Point3d.new(8*ft_to_m,0.25*ft_to_m,26*ft_to_m)
      sepoint = OpenStudio::Point3d.new(8*ft_to_m,0.25*ft_to_m,0)
      nepoint = OpenStudio::Point3d.new(8*ft_to_m,19.75*ft_to_m,0)
      nepoint2 = OpenStudio::Point3d.new(8*ft_to_m,19.75*ft_to_m,26*ft_to_m)
      sp2e = OpenStudio::Point3dVector.new
      sp2e << sepoint2
      sp2e << sepoint
      sp2e << nepoint
      sp2e << nepoint2
      sp2East = OpenStudio::Model::Surface.new(sp2e,model)
      sp2East.setSpace(sp2)
      
      nepoint2 = OpenStudio::Point3d.new(8*ft_to_m,19.75*ft_to_m,26*ft_to_m)
      nepoint = OpenStudio::Point3d.new(8*ft_to_m,19.75*ft_to_m,0)
      nwpoint = OpenStudio::Point3d.new(0,19.75*ft_to_m,0)
      nwpoint2 = OpenStudio::Point3d.new(0,19.75*ft_to_m,26*ft_to_m)
      sp2n = OpenStudio::Point3dVector.new
      sp2n << nepoint2
      sp2n << nepoint
      sp2n << nwpoint
      sp2n << nwpoint2
      sp2North = OpenStudio::Model::Surface.new(sp2n,model)
      sp2North.setSpace(sp2)
      
      nepoint2 = OpenStudio::Point3d.new(8*ft_to_m,19.75*ft_to_m,26*ft_to_m)
      nwpoint2 = OpenStudio::Point3d.new(0,19.75*ft_to_m,26*ft_to_m)
      swpoint2 = OpenStudio::Point3d.new(0,0.25*ft_to_m,26*ft_to_m)
      sepoint2 = OpenStudio::Point3d.new(8*ft_to_m,0.25*ft_to_m,26*ft_to_m)
      sp2ceil = OpenStudio::Point3dVector.new
      sp2ceil << nepoint2
      sp2ceil << nwpoint2
      sp2ceil << swpoint2
      sp2ceil << sepoint2
      sp2Ceil = OpenStudio::Model::Surface.new(sp2ceil,model)
      sp2Ceil.setSpace(sp2)
      
      nepoint = OpenStudio::Point3d.new(8*ft_to_m,19.75*ft_to_m,0)
      nwpoint = OpenStudio::Point3d.new(0,19.75*ft_to_m,0)
      swpoint = OpenStudio::Point3d.new(0,0.25*ft_to_m,0)
      sepoint = OpenStudio::Point3d.new(8*ft_to_m,0.25*ft_to_m,0)
      sp2fl = OpenStudio::Point3dVector.new
      sp2fl << sepoint
      sp2fl << swpoint
      sp2fl << nwpoint
      sp2fl << nepoint
      sp2Floor = OpenStudio::Model::Surface.new(sp2fl,model)
      sp2Floor.setSpace(sp2)
      
      
      swpoint = OpenStudio::Point3d.new(0,0.25*ft_to_m,13*ft_to_m)
      swpoint2 = OpenStudio::Point3d.new(0,0.25*ft_to_m,26*ft_to_m)
      nwpoint2 = OpenStudio::Point3d.new(0,19.75*ft_to_m,26*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(0,19.75*ft_to_m,13*ft_to_m)
      sp2e2 = OpenStudio::Point3dVector.new
      sp2e2 << swpoint
      sp2e2 << swpoint2
      sp2e2 << nwpoint2
      sp2e2 << nwpoint
      sp2East2 = OpenStudio::Model::Surface.new(sp2e2,model)
      sp2East2.setSpace(sp2)
      sp2East2.setAdjacentSurface(sp3East)
      
      swpoint = OpenStudio::Point3d.new(0,0.25*ft_to_m,10*ft_to_m)
      swpoint2 = OpenStudio::Point3d.new(0,0.25*ft_to_m,13*ft_to_m)
      nwpoint2 = OpenStudio::Point3d.new(0,19.75*ft_to_m,13*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(0,19.75*ft_to_m,10*ft_to_m)
      sp2e3 = OpenStudio::Point3dVector.new
      sp2e3 << swpoint
      sp2e3 << swpoint2
      sp2e3 << nwpoint2
      sp2e3 << nwpoint
      sp2East3 = OpenStudio::Model::Surface.new(sp2e3,model)
      sp2East3.setSpace(sp2)
      sp2East3.setAdjacentSurface(sp4East)
		
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
      OpenStudio::Model.intersectSurfaces(spaces)
      OpenStudio::Model.matchSurfaces(spaces)
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
      
    # temporary workaround to avoid intermittant issue in intersectSurfaces and matchSurfaces
    spaces = sort_spaces(spaces)
    if surface_matching
      #match surfaces for each space in the vector
      OpenStudio::Model.intersectSurfaces(spaces)
      OpenStudio::Model.matchSurfaces(spaces)
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

      # temporary workaround to avoid intermittant issue in intersectSurfaces and matchSurfaces
      spaces = sort_spaces(spaces)
      
      if surface_matching
        #match surfaces for each space in the vector
        OpenStudio::Model.intersectSurfaces(spaces)
        OpenStudio::Model.matchSurfaces(spaces)
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

      # temporary workaround to avoid intermittant issue in intersectSurfaces and matchSurfaces
        spaces = sort_spaces(spaces)

      if surface_matching
        #match surfaces for each space in the vector
        OpenStudio::Model.intersectSurfaces(spaces)
        OpenStudio::Model.matchSurfaces(spaces)
      end

      finishing_spaces = model.getSpaces
      runner.registerFinalCondition("The building finished with #{finishing_spaces.size} spaces.")
		
	  when "Test Case 6"
        #stuff here
      runner.registerInfo("Starting Test Case 6")
      facility = model.getFacility
      building = model.getBuilding
      level1 = OpenStudio::Model::BuildingStory.new(model)
      level1.setNominalFloortoFloorHeight(0)
      level1.setName("Level 1")
      level2 = OpenStudio::Model::BuildingStory.new(model)
      level2.setNominalFloortoFloorHeight(7)
      level2.setName("Level 2")

      sp1 = OpenStudio::Model::Space.new(model)
      sp1.setBuildingStory(level1)
      sp1.setName("Space_0_0")

      swpoint = OpenStudio::Point3d.new(-10,-14,0)
      nwpoint = OpenStudio::Point3d.new(-10,14,0)
      nepoint = OpenStudio::Point3d.new(10,14,0)
      sepoint = OpenStudio::Point3d.new(10,-14,0)
      flpolygon = OpenStudio::Point3dVector.new
      flpolygon << swpoint
      flpolygon << nwpoint
      flpolygon << nepoint
      flpolygon << sepoint
      floor = OpenStudio::Model::Surface.new(flpolygon,model)
      floor.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(-10,-14,0)
      point2 = OpenStudio::Point3d.new(-10,-14,7) 
      point3 = OpenStudio::Point3d.new(-10,14,7)
      point4 = OpenStudio::Point3d.new(-10,14,0)
      wpolygon = OpenStudio::Point3dVector.new
      wpolygon << point1
      wpolygon << point2
      wpolygon << point3
      wpolygon << point4
      w_wall = OpenStudio::Model::Surface.new(wpolygon,model)
      w_wall.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(-10,-14,0)
      point2 = OpenStudio::Point3d.new(10,-14,0)
      point3 = OpenStudio::Point3d.new(10,-14,7)
      point4 = OpenStudio::Point3d.new(-10,-14,7)
      spolygon = OpenStudio::Point3dVector.new
      spolygon << point1
      spolygon << point2
      spolygon << point3
      spolygon << point4
          s_wall = OpenStudio::Model::Surface.new(spolygon,model)
      s_wall.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(10,-14,0)
      point2 = OpenStudio::Point3d.new(10,14,0)
      point3 = OpenStudio::Point3d.new(10,14,7)
      point4 = OpenStudio::Point3d.new(10,-14,7)
      epolygon = OpenStudio::Point3dVector.new
      epolygon << point1
      epolygon << point2
      epolygon << point3
      epolygon << point4
      e_wall = OpenStudio::Model::Surface.new(epolygon,model)
      e_wall.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(10,14,0)
      point2 = OpenStudio::Point3d.new(-10,14,0)
      point3 = OpenStudio::Point3d.new(-10,14,7)
      point4 = OpenStudio::Point3d.new(10,14,7)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      npolygon << point4
          n_wall = OpenStudio::Model::Surface.new(npolygon,model)
      n_wall.setSpace(sp1)

      swpoint = OpenStudio::Point3d.new(-10,-14,7)
      nwpoint = OpenStudio::Point3d.new(-10,14,7)
      nepoint = OpenStudio::Point3d.new(10,14,7)
      sepoint = OpenStudio::Point3d.new(10,-14,7)
      cpolygon = OpenStudio::Point3dVector.new
      cpolygon << swpoint
      cpolygon << sepoint
      cpolygon << nepoint
      cpolygon << nwpoint
      ceil = OpenStudio::Model::Surface.new(cpolygon,model)
      ceil.setSpace(sp1)

      sp2 = OpenStudio::Model::Space.new(model)
      sp2.setBuildingStory(level1)
      sp2.setName("Space_2_0")

      swpoint = OpenStudio::Point3d.new(10,5,0)
      nwpoint = OpenStudio::Point3d.new(10,15,0)
      nepoint = OpenStudio::Point3d.new(30,15,0)
      sepoint = OpenStudio::Point3d.new(30,5,0)
      flpolygon = OpenStudio::Point3dVector.new
      flpolygon << swpoint
      flpolygon << nwpoint
      flpolygon << nepoint
      flpolygon << sepoint
      floor = OpenStudio::Model::Surface.new(flpolygon,model)
      floor.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(10,5,0)
      point2 = OpenStudio::Point3d.new(10,5,7)
      point3 = OpenStudio::Point3d.new(10,15,7)
      point4 = OpenStudio::Point3d.new(10,15,0)
      wpolygon = OpenStudio::Point3dVector.new
      wpolygon << point1
      wpolygon << point2
      wpolygon << point3
      wpolygon << point4
      wwall = OpenStudio::Model::Surface.new(wpolygon,model)
      wwall.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(10,5,0)
      point2 = OpenStudio::Point3d.new(30,5,0)
      point3 = OpenStudio::Point3d.new(30,5,7)
      point4 = OpenStudio::Point3d.new(10,5,7)
      spolygon = OpenStudio::Point3dVector.new
      spolygon << point1
      spolygon << point2
      spolygon << point3
      spolygon << point4
      swall = OpenStudio::Model::Surface.new(spolygon,model)
      swall.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(30,5,0)
      point2 = OpenStudio::Point3d.new(30,15,0)
      point3 = OpenStudio::Point3d.new(30,15,7)
      point4 = OpenStudio::Point3d.new(30,5,7)
      epolygon = OpenStudio::Point3dVector.new
      epolygon << point1
      epolygon << point2
      epolygon << point3
      epolygon << point4
      ewall = OpenStudio::Model::Surface.new(epolygon,model)
      ewall.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(30,15,0)
      point2 = OpenStudio::Point3d.new(10,15,0)
      point3 = OpenStudio::Point3d.new(10,15,7)
      point4 = OpenStudio::Point3d.new(30,15,7)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      npolygon << point4
      nwall = OpenStudio::Model::Surface.new(npolygon,model)
          nwall.setSpace(sp2)

      swpoint = OpenStudio::Point3d.new(10,5,7)
      nwpoint = OpenStudio::Point3d.new(10,15,7)
      nepoint = OpenStudio::Point3d.new(30,15,7)
      sepoint = OpenStudio::Point3d.new(30,5,7)
      cpolygon = OpenStudio::Point3dVector.new
      cpolygon << swpoint
      cpolygon << sepoint
      cpolygon << nepoint
      cpolygon << nwpoint
      ceil = OpenStudio::Model::Surface.new(cpolygon,model)
      ceil.setSpace(sp2)

      sp3 = OpenStudio::Model::Space.new(model)
      sp3.setBuildingStory(level1)
      sp3.setName("Space_1_0")

      swpoint = OpenStudio::Point3d.new(10,-5,0)
      nwpoint = OpenStudio::Point3d.new(10,5,0)
      nepoint = OpenStudio::Point3d.new(30,5,0)
      sepoint = OpenStudio::Point3d.new(30,-5,0)
      flpolygon = OpenStudio::Point3dVector.new
      flpolygon << swpoint
      flpolygon << nwpoint
      flpolygon << nepoint
      flpolygon << sepoint
      floor = OpenStudio::Model::Surface.new(flpolygon,model)
      floor.setSpace(sp3)

      point1 = OpenStudio::Point3d.new(10,-5,0)
      point2 = OpenStudio::Point3d.new(10,-5,7)
      point3 = OpenStudio::Point3d.new(10,5,7)
      point4 = OpenStudio::Point3d.new(10,5,0)
      wpolygon = OpenStudio::Point3dVector.new
      wpolygon << point1
      wpolygon << point2
      wpolygon << point3
      wpolygon << point4
      wwall = OpenStudio::Model::Surface.new(wpolygon,model)
      wwall.setSpace(sp3)

      point1 = OpenStudio::Point3d.new(10,-5,0)
      point2 = OpenStudio::Point3d.new(30,-5,0)
      point3 = OpenStudio::Point3d.new(30,-5,7)
      point4 = OpenStudio::Point3d.new(10,-5,7)
      spolygon = OpenStudio::Point3dVector.new
      spolygon << point1
      spolygon << point2
      spolygon << point3
      spolygon << point4
      swall = OpenStudio::Model::Surface.new(spolygon,model)
      swall.setSpace(sp3)

      point1 = OpenStudio::Point3d.new(30,-5,0)
      point2 = OpenStudio::Point3d.new(30,5,0)
      point3 = OpenStudio::Point3d.new(30,5,7)
      point4 = OpenStudio::Point3d.new(30,-5,7)
      epolygon = OpenStudio::Point3dVector.new
      epolygon << point1
      epolygon << point2
      epolygon << point3
      epolygon << point4
      ewall = OpenStudio::Model::Surface.new(epolygon,model)
      ewall.setSpace(sp3)

      point1 = OpenStudio::Point3d.new(30,5,0)
      point2 = OpenStudio::Point3d.new(10,5,0)
      point3 = OpenStudio::Point3d.new(10,5,7)
      point4 = OpenStudio::Point3d.new(30,5,7)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      npolygon << point4
      nwall = OpenStudio::Model::Surface.new(npolygon,model)
      nwall.setSpace(sp3)

      swpoint = OpenStudio::Point3d.new(10,-5,7)
      nwpoint = OpenStudio::Point3d.new(10,5,7)
      nepoint = OpenStudio::Point3d.new(30,5,7)
      sepoint = OpenStudio::Point3d.new(30,-5,7)
      cpolygon = OpenStudio::Point3dVector.new
      cpolygon << swpoint
      cpolygon << sepoint
      cpolygon << nepoint
      cpolygon << nwpoint
      ceil = OpenStudio::Model::Surface.new(cpolygon,model)
      ceil.setSpace(sp3)

      sp4 = OpenStudio::Model::Space.new(model)
      sp4.setBuildingStory(level1)
      sp4.setName("Space_3_0")

      swpoint = OpenStudio::Point3d.new(10,-15,0)
      nwpoint = OpenStudio::Point3d.new(10,-5,0)
      nepoint = OpenStudio::Point3d.new(30,-5,0)
      sepoint = OpenStudio::Point3d.new(30,-15,0)
      flpolygon = OpenStudio::Point3dVector.new
      flpolygon << swpoint
      flpolygon << nwpoint
      flpolygon << nepoint
      flpolygon << sepoint
      floor = OpenStudio::Model::Surface.new(flpolygon,model)
      floor.setSpace(sp4)

      point1 = OpenStudio::Point3d.new(10,-15,0)
      point2 = OpenStudio::Point3d.new(10,-15,7)
      point3 = OpenStudio::Point3d.new(10,-5,7)
      point4 = OpenStudio::Point3d.new(10,-5,0)
      wpolygon = OpenStudio::Point3dVector.new
      wpolygon << point1
      wpolygon << point2
      wpolygon << point3
      wpolygon << point4
      wwall = OpenStudio::Model::Surface.new(wpolygon,model)
      wwall.setSpace(sp4)

      point1 = OpenStudio::Point3d.new(10,-15,0)
      point2 = OpenStudio::Point3d.new(30,-15,0)
      point3 = OpenStudio::Point3d.new(30,-15,7)
      point4 = OpenStudio::Point3d.new(10,-15,7)
      spolygon = OpenStudio::Point3dVector.new
      spolygon << point1
      spolygon << point2
      spolygon << point3
      spolygon << point4
      swall = OpenStudio::Model::Surface.new(spolygon,model)
      swall.setSpace(sp4)

      point1 = OpenStudio::Point3d.new(30,-15,0)
      point2 = OpenStudio::Point3d.new(30,-5,0)
      point3 = OpenStudio::Point3d.new(30,-5,7)
      point4 = OpenStudio::Point3d.new(30,-15,7)
      epolygon = OpenStudio::Point3dVector.new
      epolygon << point1
      epolygon << point2
      epolygon << point3
      epolygon << point4
      ewall = OpenStudio::Model::Surface.new(epolygon,model)
      ewall.setSpace(sp4)

      point1 = OpenStudio::Point3d.new(30,-5,0)
      point2 = OpenStudio::Point3d.new(10,-5,0)
      point3 = OpenStudio::Point3d.new(10,-5,7)
      point4 = OpenStudio::Point3d.new(30,-5,7)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      npolygon << point4
      nwall = OpenStudio::Model::Surface.new(npolygon,model)
      nwall.setSpace(sp4)

      swpoint = OpenStudio::Point3d.new(10,-15,7)
      nwpoint = OpenStudio::Point3d.new(10,-5,7)
      nepoint = OpenStudio::Point3d.new(30,-5,7)
      sepoint = OpenStudio::Point3d.new(30,-15,7)
      cpolygon = OpenStudio::Point3dVector.new
      cpolygon << swpoint
      cpolygon << sepoint
      cpolygon << nepoint
      cpolygon << nwpoint
      ceil = OpenStudio::Model::Surface.new(cpolygon,model)
      ceil.setSpace(sp4)

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
      spaces = sort_spaces(spaces)
      if surface_matching
        #match surfaces for each space in the vector
         OpenStudio::Model.intersectSurfaces(spaces)
        OpenStudio::Model.matchSurfaces(spaces)
       
      end

      finishing_spaces = model.getSpaces
      runner.registerFinalCondition("The building finished with #{finishing_spaces.size} spaces.")	

    when "Test Case 7"
        #stuff here
      runner.registerInfo("Starting Test Case 7")
      facility = model.getFacility
      building = model.getBuilding
      level1 = OpenStudio::Model::BuildingStory.new(model)
      level1.setNominalFloortoFloorHeight(0)
      level1.setName("Level 1")
      level2 = OpenStudio::Model::BuildingStory.new(model)
      level2.setNominalFloortoFloorHeight(10*ft_to_m)
      level2.setName("Level 2")
      roofBase = OpenStudio::Model::BuildingStory.new(model)
      roofBase.setNominalFloortoFloorHeight(20*ft_to_m)
      roofBase.setName("Roof Base")
      
      sp1 = OpenStudio::Model::Space.new(model)
      sp1.setBuildingStory(level1)
      sp1.setName("sp-1-Space")

      swpoint = OpenStudio::Point3d.new(0,0,0)
      nwpoint = OpenStudio::Point3d.new(0,40*ft_to_m,0)
      nepoint = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,0)
      sepoint = OpenStudio::Point3d.new(40*ft_to_m,0,0)
      flpolygon = OpenStudio::Point3dVector.new
      flpolygon << swpoint
      flpolygon << nwpoint
      flpolygon << nepoint
      flpolygon << sepoint
      floor = OpenStudio::Model::Surface.new(flpolygon,model)
      floor.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(0,0,0)
      point2 = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      point3 = OpenStudio::Point3d.new(0,40*ft_to_m,10*ft_to_m)
      point4 = OpenStudio::Point3d.new(0,40*ft_to_m,0)
      wpolygon = OpenStudio::Point3dVector.new
      wpolygon << point1
      wpolygon << point2
      wpolygon << point3
      wpolygon << point4
      w_wall = OpenStudio::Model::Surface.new(wpolygon,model)
      w_wall.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(0,0,0)
      point2 = OpenStudio::Point3d.new(40*ft_to_m,0,0)
      point3 = OpenStudio::Point3d.new(40*ft_to_m,0,10*ft_to_m)
      point4 = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      spolygon = OpenStudio::Point3dVector.new
      spolygon << point1
      spolygon << point2
      spolygon << point3
      spolygon << point4
      s_wall = OpenStudio::Model::Surface.new(spolygon,model)
      s_wall.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(40*ft_to_m,0,0)
      point2 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,0)
      point3 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,10*ft_to_m)
      point4 = OpenStudio::Point3d.new(40*ft_to_m,0,10*ft_to_m)
      epolygon = OpenStudio::Point3dVector.new
      epolygon << point1
      epolygon << point2
      epolygon << point3
      epolygon << point4
      e_wall = OpenStudio::Model::Surface.new(epolygon,model)
      e_wall.setSpace(sp1)

      point1 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,0)
      point2 = OpenStudio::Point3d.new(0*ft_to_m,40*ft_to_m,0)
      point3 = OpenStudio::Point3d.new(0*ft_to_m,40*ft_to_m,10*ft_to_m)
      point4 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,10*ft_to_m)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      npolygon << point4
      n_wall = OpenStudio::Model::Surface.new(npolygon,model)
      n_wall.setSpace(sp1)

      swpoint = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(0,40*ft_to_m,10*ft_to_m)
      nepoint = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,10*ft_to_m)
      sepoint = OpenStudio::Point3d.new(40*ft_to_m,0,10*ft_to_m)
      cpolygon = OpenStudio::Point3dVector.new
      cpolygon << swpoint
      cpolygon << sepoint
      cpolygon << nepoint
      cpolygon << nwpoint
      ceil = OpenStudio::Model::Surface.new(cpolygon,model)
      ceil.setSpace(sp1)

      sp2 = OpenStudio::Model::Space.new(model)
      sp2.setBuildingStory(level2)
      sp2.setName("sp-2-Space")

      swpoint = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      nwpoint = OpenStudio::Point3d.new(0,40*ft_to_m,10*ft_to_m)
      nepoint = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,10*ft_to_m)
      sepoint = OpenStudio::Point3d.new(40*ft_to_m,0,10*ft_to_m)
      flpolygon = OpenStudio::Point3dVector.new
      flpolygon << swpoint
      flpolygon << nwpoint
      flpolygon << nepoint
      flpolygon << sepoint
      floor = OpenStudio::Model::Surface.new(flpolygon,model)
      floor.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      point2 = OpenStudio::Point3d.new(0,0,20*ft_to_m)
      point3 = OpenStudio::Point3d.new(0,40*ft_to_m,20*ft_to_m)
      point4 = OpenStudio::Point3d.new(0,40*ft_to_m,10*ft_to_m)
      wpolygon = OpenStudio::Point3dVector.new
      wpolygon << point1
      wpolygon << point2
      wpolygon << point3
      wpolygon << point4
      wwall = OpenStudio::Model::Surface.new(wpolygon,model)
      wwall.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(0,0,10*ft_to_m)
      point2 = OpenStudio::Point3d.new(40*ft_to_m,0,10*ft_to_m)
      point3 = OpenStudio::Point3d.new(40*ft_to_m,0,20*ft_to_m)
      point4 = OpenStudio::Point3d.new(0,0,20*ft_to_m)
      spolygon = OpenStudio::Point3dVector.new
      spolygon << point1
      spolygon << point2
      spolygon << point3
      spolygon << point4
      swall = OpenStudio::Model::Surface.new(spolygon,model)
      swall.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(40*ft_to_m,0,10*ft_to_m)
      point2 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,10*ft_to_m)
      point3 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,20*ft_to_m)
      point4 = OpenStudio::Point3d.new(40*ft_to_m,0,20*ft_to_m)
      epolygon = OpenStudio::Point3dVector.new
      epolygon << point1
      epolygon << point2
      epolygon << point3
      epolygon << point4
      ewall = OpenStudio::Model::Surface.new(epolygon,model)
      ewall.setSpace(sp2)

      point1 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,10*ft_to_m)
      point2 = OpenStudio::Point3d.new(0,40*ft_to_m,10*ft_to_m)
      point3 = OpenStudio::Point3d.new(0,40*ft_to_m,20*ft_to_m)
      point4 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,20*ft_to_m)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      npolygon << point4
      nwall = OpenStudio::Model::Surface.new(npolygon,model)
      nwall.setSpace(sp2)

      #nw roof
      point1 = OpenStudio::Point3d.new(0,0,20*ft_to_m)
      point2 = OpenStudio::Point3d.new(20*ft_to_m,20*ft_to_m,36.1886*ft_to_m)
      point3 = OpenStudio::Point3d.new(0,40*ft_to_m,20*ft_to_m)
      nwpolygon = OpenStudio::Point3dVector.new
      nwpolygon << point1
      nwpolygon << point2
      nwpolygon << point3
      nwroof = OpenStudio::Model::Surface.new(nwpolygon,model)
      nwroof.setSpace(sp2)
      #n roof
      point1 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,20*ft_to_m)
      point2 = OpenStudio::Point3d.new(0,40*ft_to_m,20*ft_to_m)
      point3 = OpenStudio::Point3d.new(20*ft_to_m,20*ft_to_m,36.1886*ft_to_m)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      nroof = OpenStudio::Model::Surface.new(npolygon,model)
      nroof.setSpace(sp2)
      #ne roof
      point1 = OpenStudio::Point3d.new(40*ft_to_m,0,20*ft_to_m)
      point2 = OpenStudio::Point3d.new(40*ft_to_m,40*ft_to_m,20*ft_to_m)
      point3 = OpenStudio::Point3d.new(20*ft_to_m,20*ft_to_m,36.1886*ft_to_m)
      npolygon = OpenStudio::Point3dVector.new
      npolygon << point1
      npolygon << point2
      npolygon << point3
      nroof = OpenStudio::Model::Surface.new(npolygon,model)
      nroof.setSpace(sp2)
      
      #ne gable panel
      point1 = OpenStudio::Point3d.new(25.0589*ft_to_m,0,20*ft_to_m)
      point2 = OpenStudio::Point3d.new(20*ft_to_m,13.49*ft_to_m,30.11783*ft_to_m)
      point3 = OpenStudio::Point3d.new(20*ft_to_m,0,30.11783*ft_to_m)
      negpolygon = OpenStudio::Point3dVector.new
      negpolygon << point1
      negpolygon << point2
      negpolygon << point3
      negroof = OpenStudio::Model::Surface.new(negpolygon,model)
      negroof.setSpace(sp2)
      #nw gable panel
      point1 = OpenStudio::Point3d.new(14.941085*ft_to_m,0,20*ft_to_m)
      point2 = OpenStudio::Point3d.new(20*ft_to_m,0,30.11783*ft_to_m)
      point3 = OpenStudio::Point3d.new(20*ft_to_m,13.49*ft_to_m,30.11783*ft_to_m)
      nwgpolygon = OpenStudio::Point3dVector.new
      nwgpolygon << point1
      nwgpolygon << point2
      nwgpolygon << point3
      nwgroof = OpenStudio::Model::Surface.new(nwgpolygon,model)
      nwgroof.setSpace(sp2)
      #s roof panel
      point1 = OpenStudio::Point3d.new(14.941085*ft_to_m,0,20*ft_to_m)
      point2 = OpenStudio::Point3d.new(20*ft_to_m,13.49*ft_to_m,30.11783*ft_to_m)
      point3 = OpenStudio::Point3d.new(25.0589*ft_to_m,0,20*ft_to_m)
      point4 = OpenStudio::Point3d.new(40*ft_to_m,0,20*ft_to_m)
      point5 = OpenStudio::Point3d.new(20*ft_to_m,20*ft_to_m,36.1886*ft_to_m)
      point6 = OpenStudio::Point3d.new(0,0,20*ft_to_m)
      srpolygon = OpenStudio::Point3dVector.new
      srpolygon << point1
      srpolygon << point2
      srpolygon << point3
      srpolygon << point4
      srpolygon << point5
      srpolygon << point6
      sroof = OpenStudio::Model::Surface.new(srpolygon,model)
      sroof.setSpace(sp2)
      #gable wall
      point1 = OpenStudio::Point3d.new(14.941085*ft_to_m,0,20*ft_to_m)
      point2 = OpenStudio::Point3d.new(25.0589*ft_to_m,0,20*ft_to_m)
      point3 = OpenStudio::Point3d.new(20*ft_to_m,0,30.11783*ft_to_m)
      gwpolygon = OpenStudio::Point3dVector.new
      gwpolygon << point1
      gwpolygon << point2
      gwpolygon << point3
      gwall = OpenStudio::Model::Surface.new(gwpolygon,model)
      gwall.setSpace(sp2)

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
      spaces = sort_spaces(spaces)
      if surface_matching
        #match surfaces for each space in the vector
         OpenStudio::Model.intersectSurfaces(spaces)
        OpenStudio::Model.matchSurfaces(spaces)
       
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
