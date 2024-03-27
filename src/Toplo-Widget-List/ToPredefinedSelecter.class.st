Class {
	#name : #ToPredefinedSelecter,
	#superclass : #ToEffectiveSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToPredefinedSelecter class >> selectionModel: aSelectionModel operator: anOperator [

	^ self new
		  selectionModel: aSelectionModel;
		  operator: anOperator;
		  yourself
]
