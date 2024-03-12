Class {
	#name : #ToListElementCommand,
	#superclass : #ToBasicCommand,
	#instVars : [
		'operator'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToListElementCommand >> applyIn: aTarget [
	" dispatch that should send back #applyOn:in: to myself"

	self operator applyCommand: self in: aTarget
]

{ #category : #hook }
ToListElementCommand >> applyOn: anOperator in: aTarget [

]

{ #category : #accessing }
ToListElementCommand >> operator [

	^ operator
]

{ #category : #accessing }
ToListElementCommand >> operator: aSelectionModelOperator [

	operator := aSelectionModelOperator
]
