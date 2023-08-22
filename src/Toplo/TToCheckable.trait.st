Trait {
	#name : #TToCheckable,
	#instVars : [
		'#group',
		'#checked => ObservableSlot',
		'#withIndeterminate',
		'#checkedImage',
		'#uncheckedImage',
		'#indeterminateImage',
		'#disabledImage'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - checkable - group' }
TToCheckable >> addToGroup: aToggleGroup [

	aToggleGroup add: self.
	self group: aToggleGroup 
]

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

	checked = aBooleanOrNil ifTrue: [ ^ self ].
	" aBoolean can be nil for indeterminate "
	(aBooleanOrNil notNil and: [ self group notNil ]) ifTrue: [ " ask the group for checking/unchecking "
		^ aBooleanOrNil
			  ifTrue: [ self group checked: self ]
			  ifFalse: [ self group unchecked: self ] ].
	self privateChecked: aBooleanOrNil
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkedImage [

	^ checkedImage
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> checkedImage: anImage [

	checkedImage := anImage
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> disabledImage [

	^ disabledImage
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> disabledImage: anImage [

	disabledImage := anImage
]

{ #category : #'t - checkable - group' }
TToCheckable >> group [

	^ group
]

{ #category : #'t - checkable - group' }
TToCheckable >> group: aCheckableGroup [

	self withIndeterminate ifTrue: [
		Error signal:
			'Invalid checkable use: indeterminate state is not allowed with a checkable group' ].

	group := aCheckableGroup
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> indeterminateImage [

	^ indeterminateImage
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> indeterminateImage: anImage [

	indeterminateImage := anImage
]

{ #category : #initialization }
TToCheckable >> initialize [

	self class initializeSlots: self.
	super initialize.
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

{ #category : #'t - checkable - group' }
TToCheckable >> removeFromGroup [

	self group remove: self
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

{ #category : #'t - checkable - accessing' }
TToCheckable >> uncheckedImage [

	^ uncheckedImage
]

{ #category : #'t - checkable - accessing' }
TToCheckable >> uncheckedImage: anImage [

	uncheckedImage := anImage
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

	self group ifNotNil: [
		Error signal: 'Indeterminate state is not allowed with a checkable group' ].
	withIndeterminate := aBoolean
]
