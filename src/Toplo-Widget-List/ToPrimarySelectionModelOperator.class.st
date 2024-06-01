Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToStandardSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> notifySelectionChangedAfter: aCommand [

	| preNotification eventToNotify |
	
	aCommand selectionChanged ifFalse: [ ^ self ].
	aCommand target dispatchEvent:
		(ToPrimarySelectionCommandAppliedEvent new
			 command: aCommand;
			 yourself).

	eventToNotify := ToListPrimarySelectionChangedEvent new
		                 selectionModel: aCommand selectionModel;
		                 yourself.

	preNotification := ToListPrimarySelectionChangePreNotificationEvent
		                   new
		                   sourceEvent: eventToNotify;
		                   yourself.

	aCommand target dispatchPreNotificationEvent: preNotification
]

{ #category : #'command operations' }
ToPrimarySelectionModelOperator >> scrollCommand: aCommand [ 

	aCommand target scrollToDataSourcePosition: aCommand index
]
