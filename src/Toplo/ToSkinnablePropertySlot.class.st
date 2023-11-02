Class {
	#name : #ToSkinnablePropertySlot,
	#superclass : #IndexedSlot,
	#category : 'Toplo-Core-Slots'
}

{ #category : #initialization }
ToSkinnablePropertySlot >> initialize: anObject [

	| property |
	property := anObject propertyNamed: self name.
	property ifNil: [ ^ InvalidSlotName signalFor: self name ].
	super write: property to: anObject
]

{ #category : #'meta-object-protocol' }
ToSkinnablePropertySlot >> rawRead: anObject [

	<reflection: 'Object Inspection - State inspection'>
	^ super read: anObject
]

{ #category : #'meta-object-protocol' }
ToSkinnablePropertySlot >> read: anObject [

	<reflection: 'Object Inspection - State inspection'>
	^ (self rawRead: anObject) read: anObject
]

{ #category : #'meta-object-protocol' }
ToSkinnablePropertySlot >> wantsInitialization [

	^ true
]

{ #category : #'meta-object-protocol' }
ToSkinnablePropertySlot >> write: aValue to: anObject [

	<reflection: 'Object Modification - State modification'>
	(self rawRead: anObject) write: aValue to: anObject.
	^ aValue
]
