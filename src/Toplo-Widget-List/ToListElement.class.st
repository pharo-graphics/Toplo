Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#instVars : [
		'secondarySelectionMode',
		'additionalSelecterIndex'
	],
	#category : #'Toplo-Widget-List-Core'
}

{ #category : #accessing }
ToListElement >> additionalSelecterIndex [

	^ additionalSelecterIndex
]

{ #category : #'additional selecters' }
ToListElement >> additionalSelecterWithId: anUniqueId [

	^ additionalSelecterIndex at: anUniqueId ifAbsent: [  ]
]

{ #category : #'additional selecters' }
ToListElement >> changeAdditionalSelecterWithId: aUniqueId with: aSelecter [

	self unrecordAdditionalSelecter:
		(self additionalSelecterWithId: aUniqueId).
	aSelecter ifNil: [ ^ self ].
	aSelecter uniqueId: aUniqueId.
	self recordAdditionalSelecter: aSelecter
]

{ #category : #accessing }
ToListElement >> data [

	self
		deprecated: 'Please use dataAccessor instead.'
		transformWith:
			'`@receiver data'
				-> '`@receiver dataAccessor'.
	^ self dataAccessor
]

{ #category : #initialization }
ToListElement >> defaultEventHandler [

	^ ToListElementEventHandler new
]

{ #category : #initialization }
ToListElement >> defaultNodeHolderFactory [

	^ [ ToNodeHolder new ]
]

{ #category : #initialization }
ToListElement >> defaultSecondarySelectionEventHandler [

	^ ToListSecondarySelectionElementEventHandler new
]

{ #category : #initialization }
ToListElement >> defaultSecondarySelectionMode [

	^ (ToListSelectionMode secondaryOn: self) beMultipleSelection
]

{ #category : #accessing }
ToListElement >> disabledSelecter [ 

	^ self additionalSelecterWithId: #disabled
]

{ #category : #accessing }
ToListElement >> disabledSelectionModel [

	^ self selectionModel disabledSelectionModel
]

{ #category : #accessing }
ToListElement >> hiddenSelecter [ 

	^ self additionalSelecterWithId: #hidden
]

{ #category : #accessing }
ToListElement >> hiddenSelectionModel [

	^ self selectionModel hiddenSelectionModel
]

{ #category : #initialization }
ToListElement >> infiniteSharedEvents [

	^ super infiniteSharedEvents , { ToInfiniteScrollFinishedEvent }
]

{ #category : #initialization }
ToListElement >> initialize [

	super initialize.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler.
	additionalSelecterIndex := SmallIdentityDictionary new.
	ToUnselectableSelectionModelSelecter on: self.
	ToDisabledSelectionModelSelecter on: self.
	ToHiddenSelectionModelSelecter on: self
]

{ #category : #'instance creation' }
ToListElement >> newPrimarySelectionModel [

	^ ToListElementSelectionModel new
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'instance creation' }
ToListElement >> newSecondarySelectionModel [

	^ ToListElementSelectionModel new
]

{ #category : #'additional selecters' }
ToListElement >> recordAdditionalSelecter: aSelecter [

	aSelecter ifNil: [ ^ self ].
	additionalSelecterIndex
		at: aSelecter uniqueId
		ifPresent: [
		Error signal: 'A selecter with the same id already exists' ].
	additionalSelecterIndex
		at: aSelecter uniqueId
		put: aSelecter
]

{ #category : #accessing }
ToListElement >> secondarySelecter [ 

	^ self secondarySelectionMode selecter
]

{ #category : #accessing }
ToListElement >> secondarySelectionElements [

	^ Array streamContents: [ :stream |
		  self childrenDo: [ :child |
			  (child isKindOf: ToListSecondarySelectionElement) ifTrue: [
				  stream nextPut: child ] ] ]
]

{ #category : #accessing }
ToListElement >> secondarySelectionMode [

	^ secondarySelectionMode
]

{ #category : #accessing }
ToListElement >> secondarySelectionMode: aSelectionMode [

	secondarySelectionMode ifNotNil: [ secondarySelectionMode onUninstalledIn: self ].
	secondarySelectionMode := aSelectionMode.
	secondarySelectionMode ifNotNil: [ secondarySelectionMode onInstalledIn: self ].
	self dispatchEvent: ToListSecondarySelectionModeChangedEvent new
]

{ #category : #accessing }
ToListElement >> secondarySelectionModel [

	^ self secondarySelectionMode selectionModel
]

{ #category : #'additional selecters' }
ToListElement >> unrecordAdditionalSelecter: aSelecter [

	aSelecter ifNil: [ ^ self ].
	additionalSelecterIndex removeKey:	aSelecter uniqueId
]

{ #category : #accessing }
ToListElement >> unselectableSelecter [

	^ self additionalSelecterWithId: #unselectable
]

{ #category : #accessing }
ToListElement >> unselectableSelectionModel [

	^ self selectionModel unselectableSelectionModel
]
