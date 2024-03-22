Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToStandardSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> listScrollCommand: aCommand in: aTarget [

	aTarget scrollToIndex: aCommand index
]

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	| preNotification eventToNotify |
	aCommand selectionChanged ifFalse: [ ^ self ].

	aTarget dispatchEvent: (ToPrimarySelectionCommandAppliedEvent new
			 command: aCommand;
			 yourself).

	eventToNotify := ToListPrimarySelectionChangedEvent new
		                 selectionModel: self selectionModel copy;
		                 yourself.

	preNotification := ToListPrimarySelectionChangePreNotificationEvent
		                   new
		                   sourceEvent: eventToNotify;
		                   yourself.
	
	aTarget dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	aTarget dispatchEvent: eventToNotify
]
