Class {
	#name : #ToListSelectionActionEvent,
	#superclass : #BlEvent,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-SelectionAction'
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
