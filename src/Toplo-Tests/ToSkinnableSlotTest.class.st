"
A ToSkinnableSlotTest is a test class for testing the behavior of ToSkinnableSlot
"
Class {
	#name : #ToSkinnableSlotTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-Slots'
}

{ #category : #tests }
ToSkinnableSlotTest >> testNew [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	space root addChild: e.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: e skinInstalledCount equals: 1.
	self assert: e skinStateQueueApplicationCount equals: 1
	
]

{ #category : #tests }
ToSkinnableSlotTest >> testWriteTo [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	e child1: ToElement new.
	space root addChild: e.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: e skinInstalledCount equals: 1.
	self assert: e skinStateQueueApplicationCount equals: 1

	
]

{ #category : #tests }
ToSkinnableSlotTest >> testWriteTo2 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.

	e child1: ToElement new.
	space root addChild: e.
	e child2: ToElement new.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: e skinInstalledCount equals: 2

	
]

{ #category : #tests }
ToSkinnableSlotTest >> testWriteTo3 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	e child1: ToElement new.
	e child1: ToElement new.
	space root addChild: e.
	space applyAllSkinInstallers.

	space applyAllEnqueuedStates.
	self assert: e skinInstalledCount equals: 1 

	
]

{ #category : #tests }
ToSkinnableSlotTest >> testWriteTo4 [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	self deny: e skinManager newSkinRequested.
	e child1: ToElement new.
	e child1: ToElement new.
	space root addChild: e.
	space applyAllSkinInstallers.

	e child1: ToElement new.
	" because of the child1: "

	self assert: e skinInstalledCount equals: 1.
	self assert: e skinManager newSkinRequested.

	space applyAllSkinInstallers.
	self assert: e skinInstalledCount equals: 2.
	self deny: e skinManager newSkinRequested.
	self assert: e skinStateQueueApplicationCount equals: 3.

	e child1: ToElement new.
	e child1: ToElement new.

	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.

	self assert: e skinInstalledCount equals: 3.
	self assert: e skinStateQueueApplicationCount equals: 5.
	self deny: e skinManager newSkinRequested.

	space applyAllSkinInstallers.

	self deny: e skinManager newSkinRequested.
	" no new state enqueued "
	self assert: e skinStateQueueApplicationCount equals: 5.
	self assert: e skinInstalledCount equals: 3
]

{ #category : #tests }
ToSkinnableSlotTest >> testWriteToWithSpaceAddChildBefore [

	| e |
	e := ToElementWithSkinnableSlotsForTest new.
	space root addChild: e.

	e child1: ToElement new.
	space applyAllSkinInstallers.
	space applyAllEnqueuedStates.
	self assert: e skinInstalledCount equals: 2 

	
]
