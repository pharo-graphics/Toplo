Class {
	#name : #ToMultiSelectHeaderEndContainer,
	#superclass : #ToSelectEndContainer,
	#instVars : [
		'maxSelectedCount',
		'currentSelectCount'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectHeaderEndContainer >> initialize [

	| selectedCountLabel |
	super initialize.
	selectedCountLabel := ToLabel new.
	selectedCountLabel constraintsDo: [ :c | c linear vertical alignCenter ].
	self startElement: selectedCountLabel
]

{ #category : #accessing }
ToMultiSelectHeaderEndContainer >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #accessing }
ToMultiSelectHeaderEndContainer >> selectedCountLabel [

	^ self startElement
]

{ #category : #accessing }
ToMultiSelectHeaderEndContainer >> updateSelectedCountLabelWith: aNumber [

	maxSelectedCount = -1 ifTrue: [ ^ self ].
	currentSelectCount = aNumber ifTrue: [ ^ self ].
	currentSelectCount := aNumber.
	self selectedCountLabel text:
		aNumber asString , ' / ' , maxSelectedCount asString
]
