Class {
	#name : #ToComboBoxHead,
	#superclass : #ToPairedButton,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxHead >> defaultPlaceholder [

	^ ToLabel new
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

{ #category : #'t - placeholder show/hide' }
ToComboBoxHead >> showPlaceholder [
	^ self subclassResponsibility
]
