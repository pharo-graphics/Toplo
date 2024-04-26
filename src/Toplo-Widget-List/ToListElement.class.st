Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#instVars : [
		'secondarySelectionMode'
	],
	#category : #'Toplo-Widget-List-Core'
}

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

	^ ToListSelectionMode secondary
]

{ #category : #accessing }
ToListElement >> disabledSelecter [ 

	^ self selecter subSelecterWithId: #disabled
]

{ #category : #accessing }
ToListElement >> disabledSelectionModel [

	^ self selectionModel disabledSelectionModel
]

{ #category : #accessing }
ToListElement >> hiddenSelecter [ 

	^ self selecter subSelecterWithId: #hidden
]

{ #category : #initialization }
ToListElement >> infiniteSharedEvents [

	^ super infiniteSharedEvents , { ToInfiniteScrollFinishedEvent }
]

{ #category : #initialization }
ToListElement >> initialize [

	super initialize.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler
]

{ #category : #'instance creation' }
ToListElement >> newPrimarySelectionModel [

	^ ToPrimarySelectionModel new
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'instance creation' }
ToListElement >> newSecondarySelectionModel [

	^ self selectionModel newSecondarySelectionModel
]

{ #category : #accessing }
ToListElement >> secondarySelecter [ 

	^ self secondarySelectionMode selecter
]

{ #category : #accessing }
ToListElement >> secondarySelectionElements [

	^ Array streamContents: [ :stream |
		  overContainer childrenDo: [ :child |
			  (child isKindOf: secondarySelectionMode elementClass) ifTrue: [
				  stream nextPut: child ] ].
		  beneathContainer childrenDo: [ :child |
			  (child isKindOf: secondarySelectionMode elementClass) ifTrue: [
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

	^ self selecter subSelecterWithId: #unselectable
]

{ #category : #accessing }
ToListElement >> unselectableSelectionModel [

	^ self unselectableSelecter selectionModel
]

{ #category : #'additional selecters' }
ToListElement >> withAdditionalSelecterWithId: aSymbol withEventClass: anEventClass [

	| additional |
	additional := ToAdditionalSelecter new.
	additional uniqueId: aSymbol.
	additional eventClass: anEventClass.
	additional parentSelecter: self selecter.
	additional onInstalledIn: self.
	^ additional
	

]

{ #category : #'additional selecters' }
ToListElement >> withDisabledSelecter [

	self withAdditionalSelecterWithId: #disabled withEventClass: ToListDisabledSelectionChangedEvent
	

]

{ #category : #'additional selecters' }
ToListElement >> withHiddenSelecter [

	self withAdditionalSelecterWithId: #hidden withEventClass: ToListHiddenSelectionChangedEvent

]

{ #category : #'additional selecters' }
ToListElement >> withUnselectableSelecter [

	self withAdditionalSelecterWithId: #unselectable withEventClass: ToListUnselectableSelectionChangedEvent

]

{ #category : #'additional selecters' }
ToListElement >> withoutDisabledSelecter [

	(self selecter subSelecterWithId: #disabled) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]

{ #category : #'additional selecters' }
ToListElement >> withoutHiddenSelecter [

	(self selecter subSelecterWithId: #hidden) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]

{ #category : #'additional selecters' }
ToListElement >> withoutUnselectableSelecter [

	(self selecter subSelecterWithId: #unselectable) ifNotNil: [ :selecter |
		selecter onUninstalledIn: self ]
]
