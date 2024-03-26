Class {
	#name : #ToPredefinedSelectionModelSelecter,
	#superclass : #ToEffectiveSelectionModelSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToPredefinedSelectionModelSelecter class >> selectionModel: aSelectionModel operator: anOperator [

	^ self new
		  selectionModel: aSelectionModel;
		  operator: anOperator;
		  yourself
]
