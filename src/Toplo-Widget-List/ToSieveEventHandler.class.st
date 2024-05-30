Class {
	#name : #ToSieveEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'listElement',
		'dataPositionIndex',
		'sieveSelectionModel'
	],
	#category : #'Toplo-Widget-List-Sieve'
}

{ #category : #'command application' }
ToSieveEventHandler >> addCommand: aCommand [ 

	aCommand target dispatchEvent: (ToElementCommandAddedEvent new
			 command: aCommand
			 yourself)
]

{ #category : #'command operations' }
ToSieveEventHandler >> addIndexesSelectionCommand: aCommand [

	self operator applyCommand: aCommand
]

{ #category : #'command operations' }
ToSieveEventHandler >> addIntervalSelectionCommand: aCommand [

	aCommand operator: self operator.
	self operator applyCommand: aCommand
]

{ #category : #'command operations' }
ToSieveEventHandler >> addWholeSelectionCommand: aCommand [


]

{ #category : #'command application' }
ToSieveEventHandler >> applyCommand: aCommand [ 

	aCommand applyOn: aCommand operator
]

{ #category : #'api - accessing' }
ToSieveEventHandler >> eventsToHandle [
	^ { ToListPrimarySelectionChangedEvent. ToListPrimarySelectionChangePreNotificationEvent}
]

{ #category : #accessing }
ToSieveEventHandler >> listElement: aSievedListElement [

	listElement := aSievedListElement
]

{ #category : #'api - accessing' }
ToSieveEventHandler >> listPrimarySelectionChangePreNotificationEvent: aPreNotification [

'listPrimarySelectionChangePreNotificationEvent:' traceCr
]

{ #category : #'api - accessing' }
ToSieveEventHandler >> listPrimarySelectionChangedEvent: anEvent [

'listPrimarySelectionChangedEvent:' traceCr
]

{ #category : #'api - hooks' }
ToSieveEventHandler >> onInstalledIn: aSieve [

	super onInstalledIn: aSieve.
	sieveSelectionModel := aSieve selectionModel.
	dataPositionIndex := aSieve originalIndexMap
]

{ #category : #'command operations' }
ToSieveEventHandler >> operator [

	^ listElement selecter operator 
]

{ #category : #'command operations' }
ToSieveEventHandler >> removeIndexesSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToSieveEventHandler >> removeIntervalSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToSieveEventHandler >> removeWholeSelectionCommand: aCommand [


]

{ #category : #'command operations' }
ToSieveEventHandler >> scrollCommand: aCommand [ 
]

{ #category : #'command operations' }
ToSieveEventHandler >> selectionModelCopyFromCommand: aCopyFromCommand [ 


]

{ #category : #'command operations' }
ToSieveEventHandler >> selectionModelShiftCommand: aCommand [ 

]
