Class {
	#name : #ToSkinnableSlot,
	#superclass : #IndexedSlot,
	#instVars : [
		'propertyName'
	],
	#category : #'Toplo-Core-Slot'
}

{ #category : #printing }
ToSkinnableSlot >> printOn: aStream [
	aStream
		store: self name;
		nextPutAll: ' => ';
		nextPutAll: self class name;
		nextPutAll: ' propertyName: ';
		store: self propertyName
]

{ #category : #accessing }
ToSkinnableSlot >> propertyName [

	^ propertyName
]

{ #category : #accessing }
ToSkinnableSlot >> propertyName: aName [

	propertyName := aName
]

{ #category : #'meta-object-protocol' }
ToSkinnableSlot >> write: aValue to: anObject [

	| prev r |
	prev := self read: anObject.

	" change the property value actually "
	r := super write: aValue to: anObject.

	" value has changed, dispath to the property parent to update the property skin"
	anObject dispatchEvent: (ToPropertyChangedEvent new
			 holder: anObject;
			 slotName: self name;
			 current: aValue;
			 previous: prev;
			 yourself).

	r ifNotNil: [ r updateSkin ].

	^ r
]
