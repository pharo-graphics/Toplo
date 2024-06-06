Class {
	#name : #ToSwitchButtonEventHandler,
	#superclass : #ToCheckableEventHandler,
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'checkable event handling' }
ToSwitchButtonEventHandler >> checkableCheckEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target icon checked: anEvent current
]

{ #category : #'api - accessing' }
ToSwitchButtonEventHandler >> eventsToHandle [ 

	^ super eventsToHandle , { ToCheckableCheckEvent }
]
