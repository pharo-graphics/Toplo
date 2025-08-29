"
A ToSpaceRootSkinTest is a test class for testing the behavior of ToSpaceRootSkin
"
Class {
	#name : #ToSpaceRootSkinTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Theme'
}

{ #category : #tests }
ToSpaceRootSkinTest >> testInstallSkinEvent [
	" test that a ToSpaceRootSkin is installed as soon a the space skin related phases are installed "

	| e goneHere |
	space := BlSpace new.
	e := ToElement new.
	e defaultSkin: ToSpaceRootSkin new.
	goneHere := false.
	space addEventHandler: (BlEventHandler
			 on: ToSpacePhasesStarted
			 do: [
				 goneHere := true.
				 e skinManager installNewSkinIn: e.
				 self deny: e background isTransparent ]).
	space root addChild: e.
	self assert: e background paint color equals: (e valueOfTokenNamed: #'background-color').
	self assert: goneHere
]
