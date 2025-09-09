Class {
	#name : #ToElementWithSkinnablePropertiesForTest,
	#superclass : #ToElement,
	#traits : 'TToElementWithSkinnableProperties',
	#classTraits : 'TToElementWithSkinnableProperties classTrait',
	#instVars : [
		'#backgroundValue => ToSkinnablePropertySlot',
		'#borderValue => ToSkinnablePropertySlot',
		'#skinStateQueueApplicationCount'
	],
	#category : #'Toplo-Tests-Core-Slots'
}

{ #category : #'instance creation' }
ToElementWithSkinnablePropertiesForTest class >> newPropertyIndex [

	^ IdentityDictionary newFrom: {
			  (#backgroundValue -> (ToSkinnableProperty
				   name: 'background'
				   reader: [ :e | e background ]
				   writer: [ :e :v | e background: v ])).
			  (#borderValue -> (ToSkinnableProperty
				   name: 'border'
				   reader: [ :e | e border ]
				   writer: [ :e :v | e border: v ])) }
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> backgroundValue [

	^ backgroundValue
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> backgroundValue: anObject [

	backgroundValue := anObject
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> borderValue [

	^ borderValue
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> borderValue: anObject [

	borderValue := anObject
]

{ #category : #initialization }
ToElementWithSkinnablePropertiesForTest >> initialize [

	super initialize.
	self class initializeSlots: self.

	" count the number of state engine applyOn: (only for dirty element stored in the space) "
	skinStateQueueApplicationCount := 0
]

{ #category : #'instance creation' }
ToElementWithSkinnablePropertiesForTest >> newSkinManager [ 

	^ ToSkinManagerForTest new
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> skinInstalledCount [

	^ self skinManager skinInstalledCount
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> skinStateQueueApplicationCount [

	^ skinStateQueueApplicationCount
]

{ #category : #initialization }
ToElementWithSkinnablePropertiesForTest >> skinStateQueueApplied [

	skinStateQueueApplicationCount := skinStateQueueApplicationCount + 1
]
