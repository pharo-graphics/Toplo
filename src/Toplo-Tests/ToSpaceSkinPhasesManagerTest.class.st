"
A ToSpaceSkinPhasesManagerTest is a test class for testing the behavior of ToSpaceSkinPhasesManager
"
Class {
	#name : 'ToSpaceSkinPhasesManagerTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-SpaceFrame',
	#package : 'Toplo-Tests',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'running' }
ToSpaceSkinPhasesManagerTest >> setUp [ 

	super setUp.
	space := self newTestingSpace.

]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testAllowSkinPhases [

	| m |
	m := ToSpaceSkinPhasesManager new.
	self assert: m allowSkinPhases.
	m allowSkinPhases: false.
	self deny: m allowSkinPhases.

	
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testCheckSkinPhasesIn [

	space checkSkinPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space skinPhasesManager isSkinPhasesInstallationPostponed.
	space allowSkinPhases: false.
	self deny: space skinPhasesManager isSkinPhasesInstallationPostponed.
	space show.
	space when: BlSpaceShownEvent do: [ :event | | theSpace |
		theSpace := event currentTarget.
		theSpace checkSkinPhases.
		" since skin phases are not allowed "
		self deny: theSpace skinPhasesManager skinPhasesInstalled.
		" now allow skin phases "
		theSpace allowSkinPhases: true.
		" since skin phases are allowed and the space is opened "
		self assert: theSpace skinPhasesManager skinPhasesInstalled ].
	

	
	
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testInitialize [

	| m |
	m := ToSpaceSkinPhasesManager new.
	self deny: m skinPhasesInstalled.
	self deny: m  isSkinPhasesInstallationPostponed.
	self assert: m allowSkinPhases
]
