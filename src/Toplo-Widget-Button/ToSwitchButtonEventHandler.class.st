Class {
	#name : #ToSwitchButtonEventHandler,
	#superclass : #ToCheckableEventHandler,
	#category : #'Toplo-Widget-Button-Switch'
}

{ #category : #'event handling' }
ToSwitchButtonEventHandler >> checkableChangedEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target icon checked: anEvent checked.
	super checkableChangedEvent: anEvent
]
