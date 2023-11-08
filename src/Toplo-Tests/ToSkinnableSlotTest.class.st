"
A ToSkinnableSlotTest is a test class for testing the behavior of ToSkinnableSlot
"
Class {
	#name : 'ToSkinnableSlotTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Slots',
	#package : 'Toplo-Tests',
	#tag : 'Core-Slots'
}

{ #category : 'running' }
ToSkinnableSlotTest >> setUp [ 

	super setUp.
	space := self newTestingSpace 
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testNew [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	space root addChild: e.
	space applyAllSkinInstallers.
	space updateAllStyles.
	self assert: e skinRequestCount equals: 1.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1
	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	e child1: ToElement new.
	space root addChild: e.
	space applyAllSkinInstallers.
	space updateAllStyles.
	space requestNextPulse.
	self assert: e skinRequestCount equals: 3.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1.
	self waitTestingSpaces.
	self assert: e skinStatesApplied equals: 1.



	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo2 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	e child1: ToElement new.
	space root addChild: e.
	e child2: ToElement new.
	space applyAllSkinInstallers.
	space updateAllStyles.
	self assert: e skinRequestCount equals: 4.
	self assert: e skinInstallStateCount equals: 1 

	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo3 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	e child1: ToElement new.
	e child1: ToElement new.
	space root addChild: e.
	space applyAllSkinInstallers.
	space updateAllStyles.
	self assert: e skinRequestCount equals: 4.
	self assert: e skinInstallStateCount equals: 1 

	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo4 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	self assert: e skinInstaller isNil.
	e child1: ToElement new.
	e child1: ToElement new.
	space root addChild: e.
	space applyAllSkinInstallers.
	space updateAllStyles.
	
	self assert: e skinRequestCount equals: 4.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 5.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinInstaller notNil.
	
	space applyAllSkinInstallers.
	space updateAllStyles.
	self assert: e skinRequestCount equals: 5.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinInstaller isNil.

	e child1: ToElement new.
	e child1: ToElement new.
	
	space applyAllSkinInstallers.
	space updateAllStyles.

	self assert: e skinRequestCount equals: 7.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 3.
	self assert: e skinInstaller isNil.

	space applyAllSkinInstallers.
	space updateAllStyles.

	self assert: e skinInstaller isNil.
	self assert: e skinRequestCount equals: 7.
	self assert: e skinStatesApplied equals: 4.
	self assert: e skinInstallStateCount equals: 1.




	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteToWithSpaceAddChildBefore [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	space root addChild: e.
	e child1: ToElement new.
	space applyAllSkinInstallers.
	space updateAllStyles.
	self assert: e skinRequestCount equals: 2.
	self assert: e skinInstallStateCount equals: 1 

	
]
