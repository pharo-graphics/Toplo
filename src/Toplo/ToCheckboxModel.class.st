Class {
	#name : #ToCheckboxModel,
	#superclass : #ToBasicButtonModel,
	#instVars : [
		'#checked => ObservableSlot'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'api - checkbox' }
ToCheckboxModel >> check [

	self checked: true
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> checked: aBooleanOrNil [

	aBooleanOrNil = checked ifTrue: [ ^ self ].
	checked := aBooleanOrNil 
]

{ #category : #'mouse handlers' }
ToCheckboxModel >> clickEvent: anEvent [

	(self isIndeterminate or: [ self isUnchecked ])
		ifTrue: [ self check ]
		ifFalse: [ self uncheck ].
	super clickEvent: anEvent
]

{ #category : #initialization }
ToCheckboxModel >> defaultCheckState [

	^ nil
]

{ #category : #initialization }
ToCheckboxModel >> defaultDresser [

	^ ToCheckboxDresser new
]

{ #category : #'api - checked change hook' }
ToCheckboxModel >> ifChecked: checkedBloc unchecked: uncheckedBloc else: indeterminateBlock [

	^ (self isIndeterminate
		   ifTrue: [ indeterminateBlock ]
		   ifFalse: [ 
			   self isChecked
				   ifTrue: [ checkedBloc ]
				   ifFalse: [ uncheckedBloc ] ]) value
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> indeterminateState [

	checked := nil
]

{ #category : #initialization }
ToCheckboxModel >> initialize [ 
	super initialize.
	checked := self defaultCheckState
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> isChecked [

	^ checked notNil and: [ checked ]
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> isIndeterminate [

	^ checked isNil
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> isUnchecked [

	^ checked notNil and: [ checked not ]
]

{ #category : #'api - hooks' }
ToCheckboxModel >> onInstalledOnlyMeIn: aToButton [

	super onInstalledOnlyMeIn: aToButton.
	aToButton when: BlDoubleClickEvent do: [ :anEvent | aToButton clickEvent: anEvent ]

]

{ #category : #'private - accessing - widget' }
ToCheckboxModel >> privateNewWidget [

	^ ToCheckbox new
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> uncheck [

	self checked: false
]

{ #category : #'api - checked change hook' }
ToCheckboxModel >> whenCheckedChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new checked value
	 - old checked value"

	self property: #checked whenChangedDo: aBlock
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenCheckedDo: aBlock [

	self
		whenCheckedChangedDo: [ self isChecked ifTrue: [ aBlock value ] ]
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenInderterminateDo: aBlock [

	self
		whenCheckedChangedDo: [ self isIndeterminate ifTrue: [ aBlock value ] ]
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenUncheckedDo: aBlock [

	self
		whenCheckedChangedDo: [ self isChecked ifFalse: [ aBlock value ] ]
]
