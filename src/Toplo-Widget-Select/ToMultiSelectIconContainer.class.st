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

{ #category : #'api - hooks' }
ToMultiSelectIconContainer >> initialize [

	super initialize.
	selectedCountLabel := ToLabel new.
	selectedCountLabel constraintsDo: [ :c | c linear vertical alignCenter ].
	self addChild: selectedCountLabel
]

{ #category : #accessing }
ToMultiSelectIconContainer >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
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
