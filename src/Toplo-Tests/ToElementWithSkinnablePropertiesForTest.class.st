Class {
	#name : 'ToElementWithSkinnablePropertiesForTest',
	#superclass : 'ToElement',
	#traits : 'TToElementWithSkinnableProperties',
	#classTraits : 'TToElementWithSkinnableProperties classTrait',
	#instVars : [
		'#skinRequestCount',
		'#skinRefreshedCount',
		'#skinStatesApplied',
		'#backgroundValue => ToSkinnablePropertySlot',
		'#borderValue => ToSkinnablePropertySlot'
	],
	#category : 'Toplo-Tests-Core-Slots',
	#package : 'Toplo-Tests',
	#tag : 'Core-Slots'
}

{ #category : 'instance creation' }
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

{ #category : 'accessing' }
ToElementWithSkinnablePropertiesForTest >> backgroundValue [

	^ backgroundValue
]

{ #category : 'accessing' }
ToElementWithSkinnablePropertiesForTest >> backgroundValue: anObject [

	backgroundValue := anObject
]

{ #category : 'accessing' }
ToElementWithSkinnablePropertiesForTest >> borderValue [

	^ borderValue
]

{ #category : 'accessing' }
ToElementWithSkinnablePropertiesForTest >> borderValue: anObject [

	borderValue := anObject
]

{ #category : 'skin' }
ToElementWithSkinnablePropertiesForTest >> flushSkinStates [

	skinStatesApplied := skinStatesApplied + 1.
	super flushSkinStates.
]

{ #category : 'initialization' }
ToElementWithSkinnablePropertiesForTest >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	" count the number of #requestSkin sents"
	skinRequestCount := 0.
	" count the number of ToSkinchangedEvent dispatches (for the skin installer)"
	skinRefreshedCount := 0.
	" count the number of state engine applyOn: (only for dirty element stored in the space) "
	skinStatesApplied := 0.
	
	self when: ToSkinInstallStateRequest do: [ skinRefreshedCount := skinRefreshedCount + 1 ]
]

{ #category : 'skin' }
ToElementWithSkinnablePropertiesForTest >> requestSkin [

	skinRequestCount := skinRequestCount + 1.
	super requestSkin.
]

{ #category : 'accessing' }
ToElementWithSkinnablePropertiesForTest >> skinRefreshedCount [

	^ skinRefreshedCount
]

{ #category : 'accessing' }
ToElementWithSkinnablePropertiesForTest >> skinRequestCount [

	^ skinRequestCount 
]

{ #category : 'accessing' }
ToElementWithSkinnablePropertiesForTest >> skinStatesApplied [

	^ skinStatesApplied
]
