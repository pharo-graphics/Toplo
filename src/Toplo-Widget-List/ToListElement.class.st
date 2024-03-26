Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#instVars : [
		'disabledSelecter',
		'unselectableSelecter',
		'secondarySelectionMode',
		'hiddenSelecter'
	],
	#category : #'Toplo-Widget-List-Core'
}

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

	^ disabledSelecter
]

{ #category : #accessing }
ToListElement >> disabledSelectionModel [

	^ self selectionModel disabledSelectionModel
]

{ #category : #accessing }
ToListElement >> hiddenSelecter [ 

	^ hiddenSelecter
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
	unselectableSelecter := ToUnselectableSelectionModelSelecter on: self.
	disabledSelecter := ToDisabledSelectionModelSelecter on: self.
	hiddenSelecter := ToHiddenSelectionModelSelecter on: self
]

{ #category : #'instance creation' }
ToListElement >> newPrimarySelectionModel [

	^ ToListPrimarySelectionModel new
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'instance creation' }
ToListElement >> newSecondarySelectionModel [

	^ ToListSecondarySelectionModel new
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

{ #category : #accessing }
ToListElement >> unselectableSelecter [

	^ unselectableSelecter
]

{ #category : #accessing }
ToListElement >> unselectableSelectionModel [

	^ self selectionModel unselectableSelectionModel
]
