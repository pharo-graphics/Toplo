"
A ToSpaceRootSkinTest is a test class for testing the behavior of ToSpaceRootSkin
"
Class {
	#name : 'ToSpaceRootSkinTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Theme',
	#package : 'Toplo-Tests',
	#tag : 'Core-Theme'
}

{ #category : 'running' }
ToSpaceRootSkinTest >> setUp [ 
	super setUp.
	space := self newTestingSpace
]

{ #category : 'tests' }
ToSpaceRootSkinTest >> testInstallLookEvent [

	| e goneHere |
	space := BlSpace new.
	e := ToElement new.
	e defaultSkin: ToSpaceRootSkin new.
	space root addChild: e.
	self assert: e background isTransparent.
	goneHere := false.
	space when: ToSpaceSkinPhasesStarted do: [
		goneHere := true.
		e applySkinInstaller.
		self deny: e background isTransparent ].
	space startSkinPhases.
	self assert: goneHere
]
