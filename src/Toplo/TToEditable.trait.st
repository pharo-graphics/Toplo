Trait {
	#name : #TToEditable,
	#instVars : [
		'#isEditable => ObservableSlot'
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
TToEditable >> initializeEditable [

	isEditable := false
]

{ #category : #'t - editable' }
TToEditable >> isEditable [

	^ isEditable 
]

{ #category : #'t - editable' }
TToEditable >> isEditable: aBoolean [

	isEditable = aBoolean ifTrue: [ ^ self ].
	isEditable := aBoolean
]

{ #category : #'change hook' }
TToEditable >> whenEditableChangedDo: aBlock [

	"Inform when editable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #isEditable whenChangedDo: aBlock
]
