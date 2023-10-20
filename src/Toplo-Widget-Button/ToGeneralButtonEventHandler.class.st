Class {
	#name : 'ToGeneralButtonEventHandler',
	#superclass : 'ToSkinnableEventHandler',
	#category : 'Toplo-Widget-Button-Core',
	#package : 'Toplo-Widget-Button',
	#tag : 'Core'
}

{ #category : 'mouse handlers' }
ToGeneralButtonEventHandler >> mouseEnterEvent: anEvent [
	" check event and current target "

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	super mouseEnterEvent: anEvent
]

{ #category : 'mouse handlers' }
ToGeneralButtonEventHandler >> mouseLeaveEvent: anEvent [
	" check event and current target "

	anEvent anyButtonPressed ifTrue: [ ^ self ].
	super mouseLeaveEvent: anEvent
]

{ #category : 'mouse handlers' }
ToGeneralButtonEventHandler >> mouseUpEvent: anEvent [
	" check event and current target "

	anEvent currentTarget ~= target ifTrue: [ ^ self ].
	super mouseUpEvent: anEvent
]
