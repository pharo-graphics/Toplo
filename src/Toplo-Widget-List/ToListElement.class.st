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

	^ ToListMultipleSelectionMode new operator:
		  (ToSecondarySelectionModelOperator new selectionModel:
			   self secondarySelectionModel)
]

{ #category : #accessing }
ToListElement >> disabledSelecter [ 

	^ disabledSelecter
]

{ #category : #accessing }
ToListElement >> disabledSelectionModel [

	^ self disabledSelecter selectionModel
]

{ #category : #accessing }
ToListElement >> hiddenSelecter [ 

	^ hiddenSelecter
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

	unselectableSelecter := self installSelecterForOperator:
		                        ToUnselectableSelectionModelOperator new.
	disabledSelecter := self installSelecterForOperator:
		                    ToDisabledSelectionModelOperator new.
	hiddenSelecter := self installSelecterForOperator:
		                    ToHiddenSelectionModelOperator new.

	self secondarySelectionModel: self newSecondarySelectionModel.
	self secondarySelectionMode: self defaultSecondarySelectionMode.
	self addEventHandler: self defaultSecondarySelectionEventHandler.

	super initializeSelectionModel
]

{ #category : #initialization }
ToListElement >> installSelecterForOperator: aSelectionOperator [

	| newSelectionModel newSelecter |
	newSelectionModel := self newSelectionModel.
	newSelectionModel onInstalledIn: self.
	newSelecter := ToMultiSelectionModelSelecter new.
	aSelectionOperator selectionModel: newSelectionModel.
	aSelectionOperator onInstalledIn: self.
	newSelecter operator: aSelectionOperator.
	newSelecter onInstalledIn: self.

	^ newSelecter
]

{ #category : #'instance creation' }
ToListElement >> newPrimarySelectionModel [

	^ ToListSelectionModel new
]

{ #category : #skin }
ToListElement >> newRawSkin [ 

	^ ToListElementSkin new
]

{ #category : #'instance creation' }
ToListElement >> newSecondarySelectionModel [

	^ ToListSelectionModel new
]

{ #category : #'event firing' }
ToListElement >> notifyDisabledSelectionChanged: aSelectionChangedEvent [

	self dispatchEvent: aSelectionChangedEvent
]

{ #category : #'event firing' }
ToListElement >> notifyHiddenSelectionChanged: aSelectionChangedEvent [

	self dispatchEvent: aSelectionChangedEvent
]

{ #category : #'event firing' }
ToListElement >> notifySecondarySelectionChanged: aSelectionChangedEvent [

	| preNotification |
	preNotification := ToListSecondarySelectionChangePreNotificationEvent new
		                   sourceEvent: aSelectionChangedEvent;
		                   yourself.
	self dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	self dispatchEvent: preNotification sourceEvent
]

{ #category : #'event firing' }
ToListElement >> notifyUnselectableSelectionChanged: aSelectionChangedEvent [

	self dispatchEvent: aSelectionChangedEvent
]

{ #category : #'selection command application' }
ToListElement >> onDisabledSelectionCommandApplied: aCommand [

	aCommand selectionChanged ifFalse: [ ^ self ].
	
	self notifyDisabledSelectionChanged:
		(ToListDisabledSelectionChangedEvent new
			 selectionModel: self disabledSelectionModel copy;
			 yourself)
]

{ #category : #'selection command application' }
ToListElement >> onHiddenSelectionCommandApplied: aCommand [

	aCommand selectionChanged ifFalse: [ ^ self ].

	self notifyHiddenSelectionChanged:
		(ToListHiddenSelectionChangedEvent new
			 selectionModel: self hiddenSelectionModel copy;
			 yourself)
]

{ #category : #'selection command application' }
ToListElement >> onSecondarySelectionCommandApplied: aCommand [

	aCommand selectionChanged ifFalse: [ ^ self ].

	self notifySecondarySelectionChanged:
		(ToListSecondarySelectionChangedEvent new
			 selectionModel: self secondarySelectionModel copy;
			 yourself)
]

{ #category : #'selection command application' }
ToListElement >> onUnselectableSelectionCommandApplied: aCommand [

	aCommand selectionChanged ifFalse: [ ^ self ].

	self notifyUnselectableSelectionChanged:
		(ToListUnselectableSelectionChangedEvent new
			 selectionModel: self unselectableSelectionModel copy;
			 yourself)
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

	^ self unselectableSelecter selectionModel
]
