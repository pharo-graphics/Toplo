Class {
	#name : #ToReadonlyComboBoxHead,
	#superclass : #ToPairedButton,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'placeholder',
		'dataElementFactory'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToReadonlyComboBoxHead >> data: aData [

	self dataElement: (self dataElementFactory cull: aData cull: self)
]

{ #category : #accessing }
ToReadonlyComboBoxHead >> dataElement: anElement [

	anElement ifNil: [ ^ self ].
	anElement vFitContent; hMatchParent.
	self first: anElement
]

{ #category : #accessing }
ToReadonlyComboBoxHead >> dataElementFactory [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	^ dataElementFactory
]

{ #category : #accessing }
ToReadonlyComboBoxHead >> dataElementFactory: aValuable [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	dataElementFactory := aValuable asToDataToElementConverter
]

{ #category : #initialization }
ToReadonlyComboBoxHead >> defaultDataElementFactory [

	^ ToActionDataToElementConverter new valuable: [ :d | ToLabel text: d ] 
]

{ #category : #'t - initialization dresser' }
ToReadonlyComboBoxHead >> defaultDresser [

	^ ToReadonlyComboBoxHeadDresser new
]

{ #category : #initialization }
ToReadonlyComboBoxHead >> defaultPlaceholder [

	^ ToLabel new
]

{ #category : #'t - placeholder show/hide' }
ToReadonlyComboBoxHead >> hidePlaceholder [

	self placeholder ifNotNil: [:ph | ph parentDo: [ :p | self placeholder removeFromParent ] ]
]

{ #category : #initialization }
ToReadonlyComboBoxHead >> initialize [ 

	super initialize.
	self dataElementFactory: self defaultDataElementFactory.
	placeholder := self defaultPlaceholder
]

{ #category : #accessing }
ToReadonlyComboBoxHead >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ToReadonlyComboBoxHead >> placeholder: anElement [

	placeholder = anElement ifTrue: [ ^ self ].
	placeholder ifNotNil: [ placeholder parentDo: [ :p | placeholder removeFromParent ] ].
	placeholder := (anElement ifNil: [ self defaultPlaceholder ])
]

{ #category : #'t - placeholder show/hide' }
ToReadonlyComboBoxHead >> showPlaceholder [

	self dataElement: self placeholder
]
