Class {
	#name : #ToCheckableGroup,
	#superclass : #Object,
	#instVars : [
		'buttons',
		'checked',
		'checkAction'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'adding / removing' }
ToCheckableGroup >> add: aCheckable [

	(buttons includes: aCheckable) ifTrue: [ ^ self ].
	buttons add: aCheckable.
	aCheckable whenCheckedDo: [ self checked: aCheckable ]

]

{ #category : #accessing }
ToCheckableGroup >> buttons [

	^ buttons
]

{ #category : #'adding / removing' }
ToCheckableGroup >> checked: aCheckable [
	(buttons select: [ :b | b ~= aCheckable ]) do: [ :b | b uncheck ].
	checkAction ifNotNil: [ checkAction cull: aCheckable cull: checked].
	checked := aCheckable 
]

{ #category : #initialization }
ToCheckableGroup >> initialize [ 

	super initialize.
	buttons := OrderedCollection new
]

{ #category : #'adding / removing' }
ToCheckableGroup >> remove: aCheckable [

	(buttons includes: aCheckable) ifFalse: [ ^ self ].
	buttons remove: aCheckable.

]

{ #category : #'api - checkbox' }
ToCheckableGroup >> whenCheckedDo: aBlock [
	"Run aBlock when one of my buttons is checked. 
	 `aBlock` receives two optional arguments: 
	 - new checked button
	 - previous checked button"

	checkAction := aBlock
]
