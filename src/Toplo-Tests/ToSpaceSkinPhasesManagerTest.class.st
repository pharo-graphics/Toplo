"
A ToSpaceSkinPhasesManagerTest is a test class for testing the behavior of ToSpaceSkinPhasesManager
"
Class {
	#name : 'ToSpaceSkinPhasesManagerTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-SpaceFrame',
	#package : 'Toplo-Tests',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testAllowSkinPhases [

	| m |
	m := ToSpaceSkinPhasesManager new.
	self assert: m allowSkinPhases.
	m allowSkinPhases: false.
	self deny: m allowSkinPhases.

	
]

{ #category : 'tests' }
ToSpaceSkinPhasesManagerTest >> testInitialize [

	| m |
	m := ToSpaceSkinPhasesManager new.
	self deny: m skinPhasesInstalled.
	self deny: m  startSkinPhasesArmed.
	self assert: m allowSkinPhases
]
