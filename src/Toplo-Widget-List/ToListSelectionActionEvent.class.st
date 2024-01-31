Class {
	#name : #ToListSelectionActionEvent,
	#superclass : #ToListSelectionEvent,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #accessing }
ToListSelectionActionEvent >> action [

	^ action
]

{ #category : #accessing }
ToListSelectionActionEvent >> action: aListSelectionAction [

	action := aListSelectionAction
]

{ #category : #sending }
ToListSelectionActionEvent >> sendTo: anObject [

	anObject listSelectionActionEvent: self
]
