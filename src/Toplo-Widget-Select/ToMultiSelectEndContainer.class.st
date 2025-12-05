Class {
	#name : #ToMultiSelectEndContainer,
	#superclass : #ToSelectEndContainer,
	#instVars : [
		'maxSelectedCount',
		'currentSelectCount'
	],
	#category : #'Toplo-Widget-Select-Multi'
}

{ #category : #initialization }
ToMultiSelectEndContainer >> initialize [

	| selectedCountLabel |
	super initialize.
	selectedCountLabel := ToLabel new.
	selectedCountLabel constraintsDo: [ :c | c linear vertical alignCenter ].
	self startElement: selectedCountLabel
]

{ #category : #accessing }
ToMultiSelectEndContainer >> maxSelectedCount: aNumber [

	maxSelectedCount := aNumber
]

{ #category : #accessing }
ToMultiSelectEndContainer >> selectedCountLabel [

	^ self startElement
]

{ #category : #accessing }
ToMultiSelectEndContainer >> updateSelectedCountLabelWith: aNumber [

	maxSelectedCount = -1 ifTrue: [ ^ self ].
	currentSelectCount = aNumber ifTrue: [ ^ self ].
	currentSelectCount := aNumber.
	self selectedCountLabel text:
		aNumber asString , ' / ' , maxSelectedCount asString
]
