Class {
	#name : #ToSkinnableSlot,
	#superclass : #IndexedSlot,
	#instVars : [
		'widgetSkinHandler'
	],
	#category : #'Toplo-Core-Slots'
}

{ #category : #'meta-object-protocol' }
ToSkinnableSlot >> write: aValue to: anObject [

	| prev r |
	prev := self read: anObject.

	" change the property value actually "
	r := super write: aValue to: anObject.

	" value has changed, dispath to the property parent to update the property skin"
	anObject dispatchEvent: (ToSkinnablePropertyChangedEvent new
			 holder: anObject;
			 slotName: self name;
			 current: aValue;
			 previous: prev;
			 yourself).

	^ r
]
