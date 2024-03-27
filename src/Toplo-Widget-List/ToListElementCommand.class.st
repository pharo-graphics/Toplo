Class {
	#name : #ToListElementCommand,
	#superclass : #ToElementBasicCommand,
	#instVars : [
		'operator',
		'selectionModel',
		'selectionChanged'
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

{ #category : #accessing }
ToListElementCommand >> selectionChanged [

	^ selectionChanged ifNil: [  selectionChanged := false ]
]

{ #category : #accessing }
ToListElementCommand >> selectionChanged: aBoolean [

	selectionChanged := aBoolean
]

{ #category : #accessing }
ToListElementCommand >> selectionModel [

	^ selectionModel
]

{ #category : #accessing }
ToListElementCommand >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]
