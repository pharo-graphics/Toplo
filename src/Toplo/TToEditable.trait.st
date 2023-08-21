Trait {
	#name : #TToEditable,
	#instVars : [
		'#isEditable => ObservableSlot'
	],
	#category : #'Toplo-Core'
}

{ #category : #'t - editable - configuration' }
TToEditable >> beEditable [

	self isEditable: true
]

{ #category : #'t - editable - configuration' }
TToEditable >> beReadOnly [

	self isEditable: false
]

{ #category : #initialization }
TToEditable >> initialize [

	self class initializeSlots: self.
	super initialize.
]

{ #category : #'t - editable - initialize' }
TToEditable >> initializeEditable [

	isEditable := false
]

{ #category : #'t - editable - configuration' }
TToEditable >> isEditable [

	^ isEditable 
]

{ #category : #'t - editable - configuration' }
TToEditable >> isEditable: aBoolean [

	isEditable = aBoolean ifTrue: [ ^ self ].
	isEditable := aBoolean
]

{ #category : #'t - editable - change hook' }
TToEditable >> whenEditableChangedDo: aBlock [

	"Inform when editable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #isEditable whenChangedDo: aBlock
]
