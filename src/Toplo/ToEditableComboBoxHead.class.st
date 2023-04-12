Class {
	#name : #ToEditableComboBoxHead,
	#superclass : #ToComboBoxHead,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'dataToTextConverter'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToEditableComboBoxHead >> dataToTextConverter [

	^ dataToTextConverter
]

{ #category : #accessing }
ToEditableComboBoxHead >> dataToTextConverter: aValuable [

	dataToTextConverter := aValuable
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultDataToTextConverter [

		^ [ :d | d ]

]

{ #category : #'t - initialization dresser' }
ToEditableComboBoxHead >> defaultDresser [

	^ ToEditableComboBoxHeadDresser new
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultPlaceholder [

	^ ToLabel new text: 'Enter text'
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultTextField [

	^ ToTextField new
]

{ #category : #'t - placeholder show/hide' }
ToEditableComboBoxHead >> hidePlaceholder [

	self textField hidePlaceholder 
]

{ #category : #initialization }
ToEditableComboBoxHead >> initialize [ 

	super initialize.
	self dataToTextConverter: self defaultDataToTextConverter.
	self textField: self defaultTextField.
	self placeholder: self defaultPlaceholder 
]

{ #category : #accessing }
ToEditableComboBoxHead >> noDataSelected [

	self showPlaceholder 
]

{ #category : #accessing }
ToEditableComboBoxHead >> placeholder [

	^ self textField placeholder
]

{ #category : #accessing }
ToEditableComboBoxHead >> placeholder: anElement [

	self textField placeholder: (anElement ifNil: [ self defaultPlaceholder ])
]

{ #category : #accessing }
ToEditableComboBoxHead >> selectedData: aData [

	self hidePlaceholder.
	self textField text: (self dataToTextConverter value: aData)


]

{ #category : #'t - placeholder show/hide' }
ToEditableComboBoxHead >> showPlaceholder [

	self textField showPlaceholder 
]

{ #category : #accessing }
ToEditableComboBoxHead >> textField [ 

	^ self first
]

{ #category : #accessing }
ToEditableComboBoxHead >> textField: aTextField [

	self first: aTextField 
]
