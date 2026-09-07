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

	| e isTransparent paintColor tokenVal |
	e := ToElement new.
	e defaultSkin: ToBackgroundColorSkinForTest new.
	space deferAndSettle: [
		space root addChild: e.
		self installNewSkinNowIn: e.
		isTransparent := e background isTransparent.
		paintColor := e background paint color.
		tokenVal := e valueOfTokenNamed: #'background-color' ].
	self deny: isTransparent.
	self assert: paintColor equals: tokenVal
]
