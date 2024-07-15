Class {
	#name : #ToSelectionCommandAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #testing }
ToSelectionCommandAppliedEvent class >> isDeprecated [ 

	^ true
]

{ #category : #accessing }
ToSelectionCommandAppliedEvent >> command [

	^ command
]

{ #category : #accessing }
ToSelectionCommandAppliedEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]

{ #category : #sending }
ToSelectionCommandAppliedEvent >> sendTo: anObject [

	anObject selectionCommandAppliedEvent: self
]
