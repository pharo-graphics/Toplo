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
	self assert: e skinRequestCount equals: 0.
	space root addChild: e.
	self assert: e skinRequestCount equals: 1.
	space applyAllSkinInstallers.
	self flag: 'is it possible to have 2 instead of 3 ?'.
	self assert: e skinRequestCount equals: 3.
	space applyAllStyles.
	self assert: e skinRequestCount equals: 3.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1
	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	self assert: e skinRequestCount equals: 0.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 1.
	space root addChild: e.
	self assert: e skinRequestCount equals: 3.
	space applyAllSkinInstallers.
	self assert: e skinRequestCount equals: 5.

	space applyAllStyles.
	self assert: e skinRequestCount equals: 5.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinStatesApplied equals: 1.
	self waitTestingSpaces.
	self assert: e skinStatesApplied equals: 1.



	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo2 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	self assert: e skinRequestCount equals: 0.

	e child1: ToElement new.
	self assert: e skinRequestCount equals: 1.
	space root addChild: e.
	self assert: e skinRequestCount equals: 3.
	e child2: ToElement new.
	self assert: e skinRequestCount equals: 4.
	space applyAllSkinInstallers.
	self assert: e skinRequestCount equals: 6.
	space applyAllStyles.
	self assert: e skinRequestCount equals: 6.
	self assert: e skinInstallStateCount equals: 1 

	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo3 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	self assert: e skinRequestCount equals: 0.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 1.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 2.
	space root addChild: e.
	self assert: e skinRequestCount equals: 4.
	space applyAllSkinInstallers.
	self assert: e skinRequestCount equals: 6.
	space applyAllStyles.
	self assert: e skinRequestCount equals: 6.
	self assert: e skinInstallStateCount equals: 1 

	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteTo4 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	self assert: e skinRequestCount equals: 0.
	self assert: e skinInstaller isNil.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 1.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 2.
	space root addChild: e.
	self assert: e skinRequestCount equals: 4.
	space applyAllSkinInstallers.
	self assert: e skinRequestCount equals: 6.
	space applyAllStyles.
	
	self assert: e skinRequestCount equals: 6.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 7.
	self assert: e skinInstallStateCount equals: 1.
	self assert: e skinInstaller notNil.
	
	space applyAllSkinInstallers.
	space applyAllStyles.
	self assert: e skinRequestCount equals: 7.
	self assert: e skinInstallStateCount equals: 2.
	self assert: e skinInstaller isNil.

	e child1: ToElement new.
	e child1: ToElement new.
	
	space applyAllSkinInstallers.
	space applyAllStyles.

	self assert: e skinRequestCount equals: 9.
	self assert: e skinInstallStateCount equals: 3.
	self assert: e skinStatesApplied equals: 3.
	self assert: e skinInstaller isNil.

	space applyAllSkinInstallers.
	space applyAllStyles.

	self assert: e skinInstaller isNil.
	self assert: e skinRequestCount equals: 9.
	self assert: e skinStatesApplied equals: 4.
	self assert: e skinInstallStateCount equals: 3.




	
]

{ #category : 'tests' }
ToSkinnableSlotTest >> testWriteToWithSpaceAddChildBefore [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	self assert: e skinRequestCount equals: 0.
	space root addChild: e.
	self assert: e skinRequestCount equals: 1.
	e child1: ToElement new.
	self assert: e skinRequestCount equals: 2.
	space applyAllSkinInstallers.
	self assert: e skinRequestCount equals: 4.
	space applyAllStyles.
	self assert: e skinRequestCount equals: 4.
	self assert: e skinInstallStateCount equals: 1 

	
]
