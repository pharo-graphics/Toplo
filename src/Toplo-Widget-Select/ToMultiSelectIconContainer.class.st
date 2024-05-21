Class {
	#name : #ToMultiSelectIconContainer,
	#superclass : #ToSelectIconContainer,
	#instVars : [
		'selectionModel',
		'selectedCountLabel',
		'maxSelectedCount'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectIconContainer >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #accessing }
ToMultiSelectIconContainer >> forFiltering: aBoolean [

	forFiltering := aBoolean
]

{ #category : #initialization }
ToMultiSelectIconContainer >> initialize [

	super initialize.
	self
		fitContent;
		id: #iconContainer;
		constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #testing }
ToMultiSelectIconContainer >> isForFiltering [ 

	^ forFiltering
]

{ #category : #accessing }
ToMultiSelectIconContainer >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #skin }
ToMultiSelectIconContainer >> newRawSkin [ 

	^ ToSelectIconContainerSkin new
]

{ #category : #'api - hooks' }
ToMultiSelectIconContainer >> onInstalledIn: aSelect [

	selectedCountLabel := ToLabel new.
	selectedCountLabel constraintsDo: [ :c | c linear vertical alignCenter ].
	self addChild: selectedCountLabel.
	iconHolder := ToElement new
		              fitContent;
		              yourself.
	iconHolder constraintsDo: [ :c | c linear vertical alignCenter ].
	self addChild: iconHolder
]

{ #category : #'api - hooks' }
ToMultiSelectIconContainer >> onUninstalledIn: aSelect [

	icon := nil.
	self removeChild: selectedCountLabel.
	selectedCountLabel := nil.
	self removeChild: iconHolder.
	iconHolder := nil
]

{ #category : #accessing }
ToMultiSelectIconContainer >> selectedCountLabel [

	^ selectedCountLabel 
]

{ #category : #accessing }
ToMultiSelectIconContainer >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToMultiSelectIconContainer >> updateSelectedCountLabel [

	maxSelectedCount isZero ifTrue: [ ^ self ].
	selectedCountLabel text:
		selectionModel selectedIndexesCount asString , ' / '
		, maxSelectedCount asString
]
