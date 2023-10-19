Class {
	#name : 'ToSkinnableSlot',
	#superclass : 'IndexedSlot',
	#category : 'Toplo-Core-Slots',
	#package : 'Toplo',
	#tag : 'Core-Slots'
}

{ #category : 'meta-object-protocol' }
ToSkinnableSlot >> write: aValue to: anObject [

	| prev r |
	prev := self read: anObject.

	" change the property value actually "
	r := super write: aValue to: anObject.
	(prev ~= r) ifTrue: [ anObject requestSkin ].

	^ r
]
