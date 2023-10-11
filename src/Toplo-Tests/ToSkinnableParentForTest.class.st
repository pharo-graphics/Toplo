Class {
	#name : #ToSkinnableParentForTest,
	#superclass : #BlElement,
	#instVars : [
		'#child => ToSkinnableSlot'
	],
	#category : #'Toplo-Tests-Core-Slot'
}

{ #category : #accessing }
ToSkinnableParentForTest >> child [

	^ child
]

{ #category : #accessing }
ToSkinnableParentForTest >> child: aSkinnableChild [

	child := aSkinnableChild
]
