Class {
	#name : #ToButtonAutomatonEventHandler,
	#superclass : #BlCustomEventHandler,
	#instVars : [
		'dresser',
		'button'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #accessing }
ToButtonAutomatonEventHandler >> button [

	^ button
]

{ #category : #accessing }
ToButtonAutomatonEventHandler >> button: aButton [

	button := aButton
]

{ #category : #'mouse handlers' }
ToButtonAutomatonEventHandler >> clickCandidateEvent: anEvent [

	anEvent target: button.
	dresser clickCandidateEvent: anEvent
]

{ #category : #accessing }
ToButtonAutomatonEventHandler >> dresser [

	^ dresser
]

{ #category : #accessing }
ToButtonAutomatonEventHandler >> dresser: anAutomatonDresser [

	dresser := anAutomatonDresser
]

{ #category : #'api - accessing' }
ToButtonAutomatonEventHandler >> eventsToHandle [
	^ { BlMouseEnterEvent. BlMouseLeaveEvent. BlMouseDownEvent. BlMouseUpEvent. BlClickCandidateEvent }
]

{ #category : #'mouse handlers' }
ToButtonAutomatonEventHandler >> mouseDownEvent: anEvent [

	anEvent target: button.
	dresser mouseDownEvent: anEvent
]

{ #category : #'mouse handlers' }
ToButtonAutomatonEventHandler >> mouseEnterEvent: anEvent [

	anEvent target: button.
	dresser mouseEnterEvent: anEvent
]

{ #category : #'mouse handlers' }
ToButtonAutomatonEventHandler >> mouseLeaveEvent: anEvent [

	anEvent target: button.
	dresser mouseLeaveEvent: anEvent
]

{ #category : #'mouse handlers' }
ToButtonAutomatonEventHandler >> mouseUpEvent: anEvent [

	anEvent target: button.
	dresser mouseUpEvent: anEvent
]
