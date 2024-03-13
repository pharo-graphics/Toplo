Class {
	#name : #ToListElement,
	#superclass : #ToBasicListElement,
	#instVars : [
		'disabledSelecter',
		'unselectableSelecter',
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

	^ disabledSelecter
]

{ #category : #initialization }
ToListElement >> infiniteSharedEvents [

	^ super infiniteSharedEvents , { ToInfiniteScrollFinishedEvent }
]

{ #category : #initialization }
ToListElement >> initializeNodeHolder: aNodeHolder forData: aData [

	super initializeNodeHolder: aNodeHolder forData: aData.
	aNodeHolder isEnabled
		ifTrue: [ aNodeHolder node enabled: true ]
		ifFalse: [ aNodeHolder node disabled: true ].
]

{ #category : #initialization }
ToListElement >> initializeSelectionModel [

	| unselectableSelectionModel operatorForUnselectableItems disabledSelectionModel operatorForDisabledItems |
	unselectableSelectionModel := self newSelectionModel.
	unselectableSelectionModel onInstalledIn: self.
	unselectableSelecter := ToMultiSelectionModelSelecter new.
	operatorForUnselectableItems := ToUnselectableSelectionModelOperator new.
	operatorForUnselectableItems selectionModel:
		unselectableSelectionModel.
	operatorForUnselectableItems onInstalledIn: self.
	unselectableSelecter operator: operatorForUnselectableItems.
	unselectableSelecter onInstalledIn: self.

	disabledSelectionModel := self newSelectionModel.
	disabledSelectionModel onInstalledIn: self.
	disabledSelecter := ToMultiSelectionModelSelecter new.
	operatorForDisabledItems := ToDisabledSelectionModelOperator new.
	operatorForDisabledItems selectionModel: disabledSelectionModel.
	operatorForDisabledItems onInstalledIn: self.
	disabledSelecter operator: operatorForDisabledItems.
	disabledSelecter onInstalledIn: self.

	self secondarySelectionModel: self newSecondarySelectionModel.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler.

	super initializeSelectionModel
]

{ #category : #'instance creation' }
ToListElement >> newPrimarySelectionModel [

	^ ToInteractiveSelectionModel new
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'instance creation' }
ToListElement >> newSecondarySelectionModel [

	^ ToInteractiveSelectionModel new
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
