Class {
	#name : #ToListSelecterCommandApplicationRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #accessing }
ToListSelecterCommandApplicationRequestEvent >> command [

	^ command
]

{ #category : #accessing }
ToListSelecterCommandApplicationRequestEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]

{ #category : #sending }
ToListSelecterCommandApplicationRequestEvent >> sendTo: anObject [

	anObject listSelecterCommandApplicationRequestEvent: self
]
