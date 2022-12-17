Trait {
	#name : #TToEditable,
	#instVars : [
		'isEditable'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - editable' }
TToEditable >> beEditable [

	self isEditable: true
]

{ #category : #'t - editable' }
TToEditable >> beReadOnly [

	self isEditable: false
]

{ #category : #'t - editable' }
TToEditable >> isEditable [

	^ isEditable 
]

{ #category : #'t - editable' }
TToEditable >> isEditable: aBoolean [

	isEditable = aBoolean ifTrue: [ ^ self ].
	isEditable := aBoolean.
	aBoolean
		ifTrue: [ self privateBeEditable ]
		ifFalse: [ self privateBeReadOnly ]
]

{ #category : #'private-change' }
TToEditable >> privateBeEditable [
	"to be implemented"
]

{ #category : #'private-change' }
TToEditable >> privateBeReadOnly [
	"to be implemented"
	
]

{ #category : #'change hook' }
TToEditable >> whenEditableChangedDo: aBlock [

	"Inform when editable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #editable whenChangedDo: aBlock
]
