Simple iOS application 
======================


Requirements
------------
1. XOS 10.11 or higher
2. Xcode 7 or higher
3. [xcpretty] 
	
	```
	gem install xcpretty
	```

4. [slather] - optional
	
	```
	gem install slather
	```

Quick Start
-----------
1. Clone the project

	```
	git clone git@github.bus.zalan.do:TIP/XCSSampleProject.git
	```

2. Navigate to project

	```
	cd XCSSampleProject
	```

Execution of UI-Tests
---------------------
### From IDE:
1. open the project

	```
	open XCSTutorialProject1.xcodeproj
	```

2. select scheme, target device and then click 'run test' icon
	
	![][IDE]

### From command line
1. run command 
	
	```
	xcodebuild test -project <xcode-project> -scheme <scheme> -destination <target-device> | xcpretty -s -r <report-type> --output <report-file>
	```

	example:

	```
	xcodebuild test -project XCSTutorialProject1.xcodeproj -scheme XCSTutorialProject1 -destination 'name=iPhone 4s,OS=9.3' | xcpretty -s -r junit --output report-junit.xml
	```

Source
------
This iOS application project is taken from [here].
	
[IDE]: <img/ide.png> "from IDE"
[xcpretty]: <https://github.com/vickeryj/XCPretty>
[slather]: <https://github.com/SlatherOrg/slather>
[here]: <https://github.com/czechboy0/XCSTutorialProject1>
