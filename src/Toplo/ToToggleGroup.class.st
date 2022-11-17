Class {
	#name : #ToToggleGroup,
	#superclass : #Object,
	#instVars : [
		'buttons',
		'checked',
		'checkAction'
	],
	#category : #'Toplo-Widget-Buttons'
}

{ #category : #'adding / removing' }
ToToggleGroup >> add: aCheckable [

	(buttons includes: aCheckable) ifTrue: [ ^ self ].
	buttons add: aCheckable.
	aCheckable whenCheckedDo: [ self checked: aCheckable ]

]

{ #category : #accessing }
ToToggleGroup >> buttons [

	^ buttons
]

{ #category : #'adding / removing' }
ToToggleGroup >> checked: aCheckable [
	
	(buttons select: [ :b | b ~= aCheckable ]) do: [ :b | b uncheck ].
	checkAction ifNotNil: [ checkAction cull: aCheckable cull: checked].
	checked := aCheckable 
]

{ #category : #initialization }
ToToggleGroup >> initialize [ 

	super initialize.
	buttons := OrderedCollection new
]

{ #category : #'adding / removing' }
ToToggleGroup >> remove: aCheckable [

	(buttons includes: aCheckable) ifFalse: [ ^ self ].
	buttons remove: aCheckable.

]

{ #category : #enumerating }
ToToggleGroup >> whenCheckedDo: aBlock [

	checkAction := aBlock
]
