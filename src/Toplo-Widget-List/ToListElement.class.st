Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#instVars : [
		'disabledSelecter',
		'unselectableSelecter',
		'secondarySelectionModel',
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

	^ ToListMultipleSelectionMode new
		  operator: ToSecondarySelectionModelOperator new;
		  selectionModel: self secondarySelectionModel;
		  yourself
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
ToListElement >> initializeSelectionModel [

	super initializeSelectionModel.
	self secondarySelectionModel: self newSecondarySelectionModel.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler.
	unselectableSelecter := self
		                        installSelecterForEventClass:
		                        ToListUnselectableSelectionChangedEvent
		                        forSelectionModel:
		                        self selectionModel
			                        unselectableSelectionModel.
	disabledSelecter := self
		                    installSelecterForEventClass:
		                    ToListDisabledSelectionChangedEvent
		                    forSelectionModel:
		                    self selectionModel disabledSelectionModel.
	hiddenSelecter := self
		                  installSelecterForEventClass:
		                  ToListHiddenSelectionChangedEvent
		                  forSelectionModel:
		                  self selectionModel hiddenSelectionModel
]

{ #category : #initialization }
ToListElement >> installSelecterForEventClass: anEventClass forSelectionModel: aSelectionModel [

	| operator |
	operator := ToAdditionalSelectionModelOperator eventClass: anEventClass.
	operator onInstalledIn: self.

	^ ToMultiSelectionModelSelecter
		  selectionModel: aSelectionModel
		  operator: operator
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

	^ unselectableSelecter
]

{ #category : #accessing }
ToListElement >> unselectableSelectionModel [

	^ self selectionModel unselectableSelectionModel
]
