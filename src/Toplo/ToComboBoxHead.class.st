Class {
	#name : #ToComboBoxHead,
	#superclass : #ToPairedButton,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxHead >> defaultPlaceholder [

	^ ToLabel new hMatchParent; yourself
]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> hidePlaceholder [
	^ self subclassResponsibility
]

{ #category : #accessing }
ToComboBoxHead >> noDataSelected [

	self subclassResponsibility 
]

{ #category : #accessing }
ToComboBoxHead >> placeholder [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToComboBoxHead >> placeholder: anElement [

	^ self subclassResponsibility
]

{ #category : #accessing }
ToComboBoxHead >> selectData: aData [

	self subclassResponsibility 
]

{ #category : #accessing }
ToComboBoxHead >> selectData: aData in: aComboBox [

	self selectData: aData
]

{ #category : #accessing }
ToComboBoxHead >> selectIndex: anIndex in: aComboBox [

	anIndex isZero ifTrue: [ ^ self noDataSelected ].
	self selectData: (aComboBox data at: anIndex) in: aComboBox
	


]

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> showPlaceholder [

	^ self subclassResponsibility
]
