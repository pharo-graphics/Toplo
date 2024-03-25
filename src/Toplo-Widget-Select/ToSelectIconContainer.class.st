Class {
	#name : #ToSelectIconContainer,
	#superclass : #ToElement,
	#instVars : [
		'select',
		'selectedCountLabel',
		'icon',
		'iconHolder'
	],
	#category : #'Toplo-Widget-Select-Core'
}

{ #category : #initialization }
ToSelectIconContainer >> defaultLayout [ 

	^ BlLinearLayout horizontal
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

{ #category : #skin }
ToSelectIconContainer >> newRawSkin [ 

	^ ToSelectIconContainerSkin new
]

{ #category : #'api - hooks' }
ToSelectIconContainer >> onInstalledIn: aSelect [

	select := aSelect.
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

	select := nil.
	icon := nil.
	self removeChild: selectedCountLabel.
	selectedCountLabel := nil.
	self removeChild: iconHolder.
	iconHolder := nil
]

{ #category : #accessing }
ToSelectIconContainer >> select [

	^ select
]

{ #category : #accessing }
ToSelectIconContainer >> selectedCountLabel [

	^ selectedCountLabel 
]

{ #category : #accessing }
ToSelectIconContainer >> updateSelectedCountLabel [

	select maxSelectedCount isZero ifTrue: [ ^ self ].
	selectedCountLabel text:
		select selectionModel selectedIndexesCount asString , ' / '
		, select maxSelectedCount asString
]
