Trait {
	#name : #TToCheckable,
	#instVars : [
		'#checked => ObservableSlot',
		'#withIndeterminate'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - checkable  - protocol' }
TToCheckable >> check [

	self checked: true
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked [

	^ checked 
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checked: aBooleanOrNil [
	" change the checkable state. nil means indeterminate. "

	| request |
	checked = aBooleanOrNil ifTrue: [ ^ self ].
	request := ToCheckableCheckRequest new
		           checked: aBooleanOrNil;
		           yourself.
	self dispatchEvent: request.
	request processed ifTrue: [ ^ self ].
	self privateChecked: request checked
]

{ #category : #'t - checkable - initializing' }
TToCheckable >> initializeCheckable [

	checked := false.
	withIndeterminate := false.
	self whenCheckedChangedDo: [ :new :prev |
		self dispatchEvent: (ToCheckableCheckEvent current: new previous: prev) ]
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isChecked [

	^ checked = true
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isIndeterminate [

	^ checked isNil
]

{ #category : #'t - checkable - testing' }
TToCheckable >> isUnchecked [

	^ checked = false
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> privateChecked: aBooleanOrNil [

	checked := aBooleanOrNil
]

{ #category : #'t - checkable - private protocol' }
TToCheckable >> switchToNextState [

	(self withIndeterminate and: [ self isUnchecked  ]) ifTrue: [ ^ self checked: nil ].
	self isIndeterminate ifTrue: [ ^ self checked: true ].
	self checked: self checked not
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> uncheck [

	self checked: false
]

{ #category : #'t - checkable - change hook' }
TToCheckable >> whenCheckedChangedDo: aBlock [

	"set a block to perform after that the slot has been changed, and its action performed"

	self property: #checked whenChangedDo: aBlock
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> withIndeterminate [

	^ withIndeterminate 
]

{ #category : #'t - checkable  - protocol' }
TToCheckable >> withIndeterminate: aBoolean [

	withIndeterminate := aBoolean
]
