"
A ToSkinInstallerTest is a test class for testing the behavior of ToSkinInstaller
"
Class {
	#name : #ToSkinInstallerTest,
	#superclass : #TestCase,
	#instVars : [
		'e'
	],
	#category : #'Toplo-Theme-Tests-Core'
}

{ #category : #tests }
ToSkinInstallerTest >> testApplyOn [

	| space |
	space := BlSpace new.
	e := ToElement new.
	space root addChild: e.
	self assert: e skinInstaller notNil
]
