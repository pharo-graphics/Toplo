Class {
	#name : #ToCheckboxModel,
	#superclass : #ToButtonModel,
	#instVars : [
		'#checked => ObservableSlot',
		'#threeSteps => ObservableSlot'
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

	threeSteps
		ifTrue: [ 
			self isIndeterminate
				ifTrue: [ self check ]
				ifFalse: [ 
					self isChecked
						ifTrue: [ self uncheck ]
						ifFalse: [ self indeterminate ] ] ]
		ifFalse: [ 
			self isUnchecked
				ifTrue: [ self check ]
				ifFalse: [ self uncheck ] ].

	super clickEvent: anEvent
]

{ #category : #initialization }
ToCheckboxModel >> defaultCheckState [

	^ false
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
ToCheckboxModel >> indeterminate [
	
	threeSteps ifFalse: [ ^ self ].
	self checked: nil
]

{ #category : #initialization }
ToCheckboxModel >> initialize [ 
	super initialize.
	threeSteps := false.
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

{ #category : #'private - accessing - widget' }
ToCheckboxModel >> privateWidgetClass [

	^ ToCheckbox
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
		whenCheckedChangedDo: [ :c | c ifTrue: [ aBlock value ] ]
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenInderterminateDo: aBlock [

	self
		whenCheckedChangedDo: [ :c | c ifNil: [ aBlock value ] ]
]

{ #category : #'api - checked change hook' }
ToCheckboxModel >> whenThreeStepsChangedDo: aBlock [
	"Inform when action block has been changed. 
	 `aBlock` receives two optional arguments: 
	 - new checked value
	 - old checked value"

	self property: #threeSteps whenChangedDo: aBlock
]

{ #category : #'api - checkbox' }
ToCheckboxModel >> whenUncheckedDo: aBlock [

	self
		whenCheckedChangedDo: [ :c | c  ifFalse: [ aBlock value ] ]
]

{ #category : #initialization }
ToCheckboxModel >> withTreeStates [

	threeSteps := true
]

{ #category : #initialization }
ToCheckboxModel >> withTwoStates [

	threeSteps := false
]
