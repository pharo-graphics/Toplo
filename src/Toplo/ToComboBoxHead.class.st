Class {
	#name : #ToComboBoxHead,
	#superclass : #ToPairedButton,
	#instVars : [
		'placeholder'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToComboBoxHead >> dataElement: anElement [

	anElement ifNil: [ ^ self ].
	anElement vFitContent; hMatchParent.
	self first: anElement
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

	self placeholder ifNotNil: [:ph | ph parentDo: [ :p | self placeholder removeFromParent ] ]
]

{ #category : #initialization }
ToComboBoxHead >> initialize [ 

	super initialize.
	placeholder := self defaultPlaceholder.
	
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
	placeholder := (anElement ifNil: [ self defaultPlaceholder ])
]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> showPlaceholder [

	self dataElement: self placeholder
]
