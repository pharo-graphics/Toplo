Class {
	#name : #ToPrimarySelectionCommandApplicationManager,
	#superclass : #ToSelectionCommandApplicationManager,
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #'command application' }
ToPrimarySelectionCommandApplicationManager >> notifyCommandApplied: aCommand withOperator: anOperator [

	| preNotification eventToNotify |
	
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
