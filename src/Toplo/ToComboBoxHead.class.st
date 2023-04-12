Class {
	#name : #ToComboBoxHead,
	#superclass : #ToPairedButton,
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #initialization }
ToComboBoxHead >> defaultPlaceholder [

	^ ToLabel new
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
ToComboBoxHead >> selectedData: aData [

	self subclassResponsibility 
]
