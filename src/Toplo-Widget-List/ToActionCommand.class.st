Class {
	#name : #ToActionCommand,
	#superclass : #ToBasicCommand,
	#instVars : [
		'action'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #accessing }
ToActionCommand >> action [

	^ action
]

{ #category : #accessing }
ToActionCommand >> action: aValuable [

	action := aValuable
]

{ #category : #hook }
ToActionCommand >> applyOn: anObject in: aTarget [

	anObject actionCommand: self in: aTarget.
	super applyOn: anObject in: aTarget

]
