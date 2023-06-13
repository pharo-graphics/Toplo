Class {
	#name : #ToSelectOnlyComboBoxHead,
	#superclass : #ToComboBoxHead,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'placeholder',
		'dataElementFactory'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> dataElement: anElement [

	anElement ifNil: [ ^ self ].
	self first: anElement
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> dataElementFactory [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	^ dataElementFactory
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> dataElementFactory: aValuable [
	" is a ToActionDataToElementConverter or any object that responds to asToDataToElementConverter as a BlockClosure for example "

	dataElementFactory := aValuable asToDataToElementConverter
]

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> defaultDataElementFactory [

	^ ToActionDataToElementConverter new valuable: [ :d | (ToLabel text: d) hMatchParent; yourself ] 
]

{ #category : #'t - initialization dresser' }
ToSelectOnlyComboBoxHead >> defaultDresser [

	^ ToSelectOnlyComboBoxHeadDresser new
]

{ #category : #'t - placeholder show/hide' }
ToSelectOnlyComboBoxHead >> hidePlaceholder [

	self placeholder ifNotNil: [:ph | ph parentDo: [ :p | self placeholder removeFromParent ] ]
]

{ #category : #initialization }
ToSelectOnlyComboBoxHead >> initialize [ 

	super initialize.
	self dataElementFactory: self defaultDataElementFactory.
	placeholder := self defaultPlaceholder
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> noDataSelected [

	self showPlaceholder 
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> placeholder [

	^ placeholder
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> placeholder: anElement [

	placeholder = anElement ifTrue: [ ^ self ].
	placeholder ifNotNil: [ placeholder parentDo: [ :p | placeholder removeFromParent ] ].
	placeholder := (anElement ifNil: [ self defaultPlaceholder ])
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> selectData: aData [

	self hidePlaceholder.
	self dataElement: (self dataElementFactory cull: aData cull: self)
]

{ #category : #accessing }
ToSelectOnlyComboBoxHead >> selectIndex: anIndex in: aComboBox [

	super selectIndex: anIndex in: aComboBox.
	aComboBox selectIndexInPresentedData: anIndex
	
]

{ #category : #'t - placeholder show/hide' }
ToSelectOnlyComboBoxHead >> showPlaceholder [

	self dataElement: self placeholder
]
