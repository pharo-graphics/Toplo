Class {
	#name : #ToSelectIconContainer,
	#superclass : #ToElement,
	#instVars : [
		'selectedCountLabel',
		'icon',
		'iconHolder',
		'maxSelectedCount',
		'selectionModel',
		'forFiltering'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectIconContainer >> defaultLayout [ 

	^ BlLinearLayout horizontal
]

{ #category : #accessing }
ToSelectIconContainer >> forFiltering: aBoolean [

	forFiltering := aBoolean
]

{ #category : #accessing }
ToSelectIconContainer >> icon [

	^ icon
]

{ #category : #accessing }
ToSelectIconContainer >> icon: anElement [

	anElement = icon ifTrue: [ ^ self ].
	icon ifNotNil: [ :s | icon removeFromParent ].
	self requestNewSkin.
	anElement ifNil: [ ^ self ].
	anElement id: #icon.
	icon := anElement.
	self iconHolder addChild: icon.

]

{ #category : #accessing }
ToSelectIconContainer >> iconHolder [

	^ iconHolder
]

{ #category : #initialization }
ToSelectIconContainer >> initialize [

	super initialize.
	self
		fitContent;
		id: #iconContainer;
		constraintsDo: [ :c | c linear vertical alignCenter ]
]

{ #category : #testing }
ToSelectIconContainer >> isForFiltering [ 

	^ forFiltering
]

{ #category : #accessing }
ToSelectIconContainer >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #skin }
ToSelectIconContainer >> newRawSkin [ 

	^ ToSelectIconContainerSkin new
]

{ #category : #'api - hooks' }
ToSelectIconContainer >> onInstalledIn: aSelect [

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
ToSelectIconContainer >> onUninstalledIn: aSelect [

	icon := nil.
	self removeChild: selectedCountLabel.
	selectedCountLabel := nil.
	self removeChild: iconHolder.
	iconHolder := nil
]

{ #category : #accessing }
ToSelectIconContainer >> selectedCountLabel [

	^ selectedCountLabel 
]

{ #category : #accessing }
ToSelectIconContainer >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToSelectIconContainer >> updateSelectedCountLabel [

	maxSelectedCount isZero ifTrue: [ ^ self ].
	selectedCountLabel text:
		selectionModel selectedIndexesCount asString , ' / '
		, maxSelectedCount asString
]
