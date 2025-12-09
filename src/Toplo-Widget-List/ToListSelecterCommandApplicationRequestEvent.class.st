Class {
	#name : #ToListSelecterCommandApplicationRequestEvent,
	#superclass : #ToAuthorisationRequestEvent,
	#instVars : [
		'command',
		'selectionModel'
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

{ #category : #accessing }
ToListSelecterCommandApplicationRequestEvent >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListSelecterCommandApplicationRequestEvent >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #sending }
ToListSelecterCommandApplicationRequestEvent >> sendTo: anObject [

	anObject listSelecterCommandApplicationRequestEvent: self
]
