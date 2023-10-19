"
A ToSkinnablePropertySlotTest is a test class for testing the behavior of ToSkinnablePropertySlot
"
Class {
	#name : 'ToSkinnablePropertySlotTest',
	#superclass : 'ToParameterizedHostTest',
	#instVars : [
		'space'
	],
	#category : 'Toplo-Tests-Core-Slots',
	#package : 'Toplo-Tests',
	#tag : 'Core-Slots'
}

{ #category : 'running' }
ToSkinnablePropertySlotTest >> setUp [ 

	super setUp.
	space := self newTestingSpace 
]

{ #category : 'running' }
ToSkinnablePropertySlotTest >> testNew [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e skinRequestCount equals: 1.
	self assert: e skinRefreshedCount equals: 1.
	self assert: e skinStatesApplied equals: 1
	
]

{ #category : 'running' }
ToSkinnablePropertySlotTest >> testWriteTo [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	self assert: e backgroundValue isTransparent.
	e backgroundValue: Color blue.
	self assert: e backgroundValue paint color equals: Color blue.
	self assert: e background paint color equals: Color blue.
	space root addChild: e.
	self waitTestingSpaces.
	self assert: e skinRequestCount equals: 2.
	self assert: e skinRefreshedCount equals: 1.
	self assert: e skinStatesApplied equals: 1.
	self waitTestingSpaces.
	self assert: e skinStatesApplied equals: 1.



	
]

{ #category : 'running' }
ToSkinnablePropertySlotTest >> testWriteTo2 [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	e backgroundValue: Color blue.
	space root addChild: e.
	self assert: e border isTransparent.
	e borderValue: Color red.
	self assert: e border paint color equals: Color red..
	self waitTestingSpaces.
	self assert: e skinRequestCount equals: 3.
	self assert: e skinRefreshedCount equals: 1 

	
]

{ #category : 'running' }
ToSkinnablePropertySlotTest >> testWriteTo4 [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	self assert: e skinInstaller isNil.
	e backgroundValue: Color blue.
	e borderValue: Color red.
	space root addChild: e.
	self waitTestingSpaces.
	
	e backgroundValue: Color blue.
	self assert: e skinRequestCount equals: 4.
	self assert: e skinRefreshedCount equals: 1.
	self assert: e skinInstaller notNil.
	
	self waitTestingSpaces.
	self assert: e skinRequestCount equals: 4.
	self assert: e skinRefreshedCount equals: 2.
	self assert: e skinInstaller isNil.

	e backgroundValue: Color blue.
	e borderValue: Color red.
	self assert: e skinRequestCount equals: 6.
	self assert: e skinRefreshedCount equals: 2.
	self assert: e skinStatesApplied equals: 2.
	self assert: e skinInstaller notNil.

	self waitTestingSpaces.
	self assert: e skinInstaller isNil.
	self assert: e skinRequestCount equals: 6.
	self assert: e skinStatesApplied equals: 3.
	self assert: e skinRefreshedCount equals: 3.




	
]

{ #category : 'running' }
ToSkinnablePropertySlotTest >> testWriteToWithSpaceAddChildBefore [

	| e |
	e := ToElementWithSkinnablePropertiesForTest new.
	space root addChild: e.
	e backgroundValue: Color blue.
	e borderValue: Color red.
	self waitTestingSpaces.
	self assert: e skinInstaller isNil.
	self assert: e skinRequestCount equals: 3.
	self assert: e skinRefreshedCount equals: 1.
	self assert: e skinStatesApplied equals: 1.

	
]
