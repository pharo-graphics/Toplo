Class {
	#name : #ToPrimarySelectionCommandAppliedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'command'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToPrimarySelectionCommandAppliedEvent >> command [

	^ command
]

{ #category : #accessing }
ToPrimarySelectionCommandAppliedEvent >> command: aSelectionCommand [

	command := aSelectionCommand
]

{ #category : #sending }
ToPrimarySelectionCommandAppliedEvent >> sendTo: anObject [

	anObject primarySelectionCommandAppliedEvent: self
]
