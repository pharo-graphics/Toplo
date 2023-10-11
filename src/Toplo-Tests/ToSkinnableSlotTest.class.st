"
A ToSkinnableSlotTest is a test class for testing the behavior of ToSkinnableSlot
"
Class {
	#name : #ToSkinnableSlotTest,
	#superclass : #TestCase,
	#category : #'Toplo-Tests-Core-Slot'
}

{ #category : #tests }
ToSkinnableSlotTest >> testWriteTo [

	| parent child |
	parent := ToSkinnableParentForTest new.
	child := ToSkinnableChildForTest new.
	self assert: child updateSkinCount isZero.
	parent child: child.
	self assert: child updateSkinCount equals: 1.
	parent child: child.
	self assert: child updateSkinCount equals: 2.
	parent child: nil.
	self assert: child updateSkinCount equals: 2.
	parent child: child.
	self assert: child updateSkinCount equals: 3
]
