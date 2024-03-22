Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#instVars : [
		'secondarySelectionModel',
		'secondarySelectionMode'
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

	^ ToListMultipleSelectionMode new operator:
		  (ToSecondarySelectionModelOperator new selectionModel:
			   self secondarySelectionModel)
]

{ #category : #accessing }
ToListElement >> disabledSelecter [ 

	^ self selectionModel disabledSelecter
]

{ #category : #accessing }
ToListElement >> disabledSelectionModel [

	^ self disabledSelecter selectionModel
]

{ #category : #accessing }
ToListElement >> hiddenSelecter [ 

	^ self selectionModel hiddenSelecter
]

{ #category : #accessing }
ToListElement >> hiddenSelectionModel [

	^ self hiddenSelecter selectionModel
]

{ #category : #initialization }
ToListElement >> infiniteSharedEvents [

	^ super infiniteSharedEvents , { ToInfiniteScrollFinishedEvent }
]

{ #category : #initialization }
ToListElement >> initializeSelectionModel [

	super initializeSelectionModel.
	self secondarySelectionModel: self newSecondarySelectionModel.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler
]

{ #category : #initialization }
ToListElement >> installSelecterForEventClass: anEventClass [

	| newSelectionModel newSelecter operator |
	operator := ToAdditionalSelectionModelOperator eventClass:
		            anEventClass.
	newSelectionModel := self newSelectionModel.
	newSelectionModel onInstalledIn: self.
	newSelecter := ToMultiSelectionModelSelecter new.
	operator selectionModel: newSelectionModel.
	operator onInstalledIn: self.
	newSelecter operator: operator.
	newSelecter onInstalledIn: self.

	^ newSelecter
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

	^ secondarySelectionModel
]

{ #category : #accessing }
ToListElement >> secondarySelectionModel: aSelectionModel [

	secondarySelectionModel ifNotNil: [ secondarySelectionModel onUninstalledIn: self ].
	secondarySelectionModel := aSelectionModel.
	secondarySelectionModel ifNotNil: [secondarySelectionModel onInstalledIn: self ]
]

{ #category : #accessing }
ToListElement >> unselectableSelecter [

	^ self selectionModel unselectableSelecter
]

{ #category : #accessing }
ToListElement >> unselectableSelectionModel [

	^ self unselectableSelecter selectionModel
]
