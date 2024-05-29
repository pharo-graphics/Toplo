Class {
	#name : #ToPrimarySelectionModelOperator,
	#superclass : #ToStandardSelectionModelOperator,
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #'command operations' }
ToPrimarySelectionModelOperator >> listScrollCommand: aCommand in: aTarget [

	aTarget scrollToDataSourcePosition: aCommand index
]

{ #category : #'private command application' }
ToPrimarySelectionModelOperator >> notifySelectionChangedAfter: aCommand in: aTarget [

	| preNotification eventToNotify |

	aCommand selectionChanged ifFalse: [ ^ self ].

	aTarget dispatchEvent: (ToPrimarySelectionCommandAppliedEvent new
			 command: aCommand;
			 yourself).

	eventToNotify := ToListPrimarySelectionChangedEvent new
		                 selectionModel: aCommand selectionModel;
		                 yourself.

	preNotification := ToListPrimarySelectionChangePreNotificationEvent
		                   new
		                   sourceEvent: eventToNotify;
		                   yourself.
	
	aTarget dispatchEvent: preNotification.
	preNotification sourceEvent ifNil: [ ^ self ].
	aTarget dispatchEvent: eventToNotify
]
