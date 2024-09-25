Class {
	#name : #ToChoiceChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'selectedData',
		'selectedIndex'
	],
	#category : #'Toplo-Widget-Menu-Choice menu deprecated'
}

{ #category : #'as yet unclassified' }
ToChoiceChangedEvent class >> isDeprecated [

	^ true
]

{ #category : #accessing }
ToChoiceChangedEvent >> selectedData [

	^ selectedData
]

{ #category : #accessing }
ToChoiceChangedEvent >> selectedData: aData [

	selectedData := aData
]

{ #category : #accessing }
ToChoiceChangedEvent >> selectedIndex [

	^ selectedIndex
]

{ #category : #accessing }
ToChoiceChangedEvent >> selectedIndex: anInteger [

	selectedIndex := anInteger
]
