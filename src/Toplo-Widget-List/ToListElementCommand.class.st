Class {
	#name : #ToListElementCommand,
	#superclass : #ToElementBasicCommand,
	#instVars : [
		'operator',
		'selectionChanged'
	],
	#category : #'Toplo-Widget-List-Command-Selection'
}

{ #category : #hook }
ToListElementCommand >> applyIn: aTarget [
	" dispatch that should send back #applyOn:in: to myself"

	aTarget layoutCritical: [ self operator applyCommand: self in: aTarget ]
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

{ #category : #accessing }
ToListElementCommand >> selectionChanged [

	^ selectionChanged ifNil: [  selectionChanged := false ]
]

{ #category : #accessing }
ToListElementCommand >> selectionChanged: aBoolean [

	selectionChanged := aBoolean
]
