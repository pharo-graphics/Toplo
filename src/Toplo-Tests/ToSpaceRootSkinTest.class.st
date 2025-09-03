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

	| e  |
	space := BlSpace new.
	e := ToElement new.
	e defaultSkin: ToBackgroundColorSkinForTest new.
	space root addChild: e.
	self installNewSkinNowIn: e.
	self deny: e background isTransparent.
	self assert: e background paint color equals: (e valueOfTokenNamed: #'background-color')
]
