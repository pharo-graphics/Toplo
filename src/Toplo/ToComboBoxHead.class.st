Class {
	#name : #ToComboBoxHead,
	#superclass : #ToGeneralButton,
	#instVars : [
		'placeholder'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxHead >> contentElement: anElement [

	anElement ifNil: [ ^ self ].
	anElement hMatchParent.
	self hasChildren
		ifTrue: [ self replaceChild: self firstChild with: anElement ]
		ifFalse: [ self addChild: anElement at: 1 ]
]

{ #category : #'t - initialization dresser' }
ToComboBoxHead >> defaultDresser [

	^ ToComboBoxHeadDresser new
]

{ #category : #initialization }
ToComboBoxHead >> defaultPlaceholder [

	^ ToLabel new
]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> hidePlaceholder [

	self placeholder parentDo: [ :p | self placeholder removeFromParent ]
]

{ #category : #initialization }
ToComboBoxHead >> initialize [ 

	super initialize.
	placeholder := self defaultPlaceholder

]

{ #category : #accessing }
ToComboBoxHead >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ToComboBoxHead >> placeholder: anElement [

	placeholder = anElement ifTrue: [ ^ self ].
	placeholder ifNotNil: [
		placeholder parentDo: [ :p | placeholder removeFromParent ] ].
	placeholder := anElement
]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> showPlaceholder [

	self contentElement: self placeholder
]
