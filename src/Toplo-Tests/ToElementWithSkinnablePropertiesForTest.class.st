Class {
	#name : #ToElementWithSkinnablePropertiesForTest,
	#superclass : #ToElement,
	#traits : 'TToElementWithSkinnableProperties',
	#classTraits : 'TToElementWithSkinnableProperties classTrait',
	#instVars : [
		'#skinRequestCount',
		'#skinStatesApplied',
		'#backgroundValue => ToSkinnablePropertySlot',
		'#borderValue => ToSkinnablePropertySlot',
		'#skinInstallStateCount'
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

	self class initializeSlots: self.
	super initialize.
	" count the number of #SkinRequest sents"
	skinRequestCount := 0.
	" count the number of ToSkinchangedEvent dispatches (for the skin installer)"
	skinInstallStateCount := 0.
	" count the number of state engine applyOn: (only for dirty element stored in the space) "
	skinStatesApplied := 0.

	self addEventHandler: (BlEventHandler
			 on: ToInstallSkinRequest
			 do: [ skinRequestCount := skinRequestCount + 1 ]).
			
	self addEventHandler: (BlEventHandler
			 on: ToSkinStateQueueAppliedEvent 
			 do: [ skinStatesApplied := skinStatesApplied + 1 ]).

	self addEventHandler: (BlEventHandler
			 on: ToInstallSkinEvent
			 do: [ skinInstallStateCount := skinInstallStateCount + 1 ])
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> skinInstallStateCount [

	^ skinInstallStateCount
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> skinRequestCount [

	^ skinRequestCount 
]

{ #category : #accessing }
ToElementWithSkinnablePropertiesForTest >> skinStatesApplied [

	^ skinStatesApplied
]
