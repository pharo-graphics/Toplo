Class {
	#name : #ToCheckableCheckRequest,
	#superclass : #BlEvent,
	#instVars : [
		'checked',
		'processed'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'checking protocol' }
ToCheckableCheckRequest >> accept [

	self currentTarget privateChecked: self checked
]

{ #category : #accessing }
ToCheckableCheckRequest >> checked [

	^ checked
]

{ #category : #accessing }
ToCheckableCheckRequest >> checked: aBoolean [

	checked := aBoolean
]

{ #category : #accessing }
ToCheckableCheckRequest >> processed [

	^ processed ifNil: [ processed := false ]
]

{ #category : #accessing }
ToCheckableCheckRequest >> processed: aBoolean [

	processed := aBoolean
]
