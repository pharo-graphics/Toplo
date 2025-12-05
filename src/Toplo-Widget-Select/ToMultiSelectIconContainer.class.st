Class {
	#name : #ToMultiSelectIconContainer,
	#superclass : #ToSelectIconContainer,
	#instVars : [
		'selectionModel',
		'maxSelectedCount'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectIconContainer >> initialize [

	| selectedCountLabel |
	super initialize.
	selectedCountLabel := ToLabel new.
	selectedCountLabel constraintsDo: [ :c | c linear vertical alignCenter ].
	self startElement: selectedCountLabel
]

{ #category : #accessing }
ToMultiSelectIconContainer >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #accessing }
ToMultiSelectIconContainer >> selectedCountLabel [

	^ self startElement
]

{ #category : #accessing }
ToMultiSelectIconContainer >> selectionModel: aSelectionModel [

	selectionModel := aSelectionModel
]

{ #category : #accessing }
ToMultiSelectIconContainer >> updateSelectedCountLabelWith: aNumber [

	"maxSelectedCount = -1 ifTrue: [ ^ self ]."
	self selectedCountLabel text:
		aNumber asString , ' / ' , maxSelectedCount asString.
	self selectedCountLabel text asString traceCr
]
