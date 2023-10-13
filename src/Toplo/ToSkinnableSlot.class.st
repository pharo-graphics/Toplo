Class {
	#name : #ToSkinnableSlot,
	#superclass : #IndexedSlot,
	#category : #'Toplo-Core-Slot'
}

{ #category : #'meta-object-protocol' }
ToSkinnableSlot >> write: aValue to: anObject [

	| r |
	" change the property value actually "
	r := super write: aValue to: anObject.

	" value has changed, dispatch to the property parent to update its skin"
	anObject updateSkin.

	^ r
]
