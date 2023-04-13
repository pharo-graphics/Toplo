Class {
	#name : #ToEditableComboBoxHead,
	#superclass : #ToComboBoxHead,
	#classTraits : 'TObservable classTrait',
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #'t - initialization dresser' }
ToEditableComboBoxHead >> defaultDresser [

	^ ToEditableComboBoxHeadDresser new
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultPlaceholder [

	^ ToLabel new text: 'Enter text'; yourself
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultTextField [

	^ ToTextField new withoutLineWrapping 
]

{ #category : #'t - placeholder show/hide' }
ToEditableComboBoxHead >> hidePlaceholder [

	self textField hidePlaceholder 
]

{ #category : #initialization }
ToEditableComboBoxHead >> initialize [ 

	super initialize.
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
ToEditableComboBoxHead >> selectData: aData [

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
