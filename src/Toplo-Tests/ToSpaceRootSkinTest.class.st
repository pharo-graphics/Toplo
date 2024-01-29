"
A ToSpaceRootSkinTest is a test class for testing the behavior of ToSpaceRootSkin
"
Class {
	#name : #ToSpaceRootSkinTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSpaceRootSkinTest >> testInstallLookEvent [
	" test that a ToSpaceRootSkin is installed as soon a the space skin related phases are installed "

	| e goneHere |
	space := BlSpace new.
	e := ToElement new.
	e defaultSkin: ToSpaceRootSkin new.
	space root addChild: e.
	self assert: e background isTransparent.
	goneHere := false.
	space addEventHandler: (BlEventHandler
			 on: ToSpaceSkinPhasesStarted
			 do: [
				 goneHere := true.
				 e skinManager applySkinReinstallIn: e.
				 self deny: e background isTransparent ]).
	space startSkinPhases.
	self assert: goneHere
]
