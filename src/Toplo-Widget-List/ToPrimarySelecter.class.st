Class {
	#name : #ToPrimarySelecter,
	#superclass : #ToCompositeSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #operations }
ToPrimarySelecter >> deselectAll [

	super deselectAll
]

{ #category : #'instance creation' }
ToPrimarySelecter >> newSieveSelecter [

	^ ToSieveSelecter new
		  selectionModel: selectionModel copy;
		  selectionChangedEventClass: selectionChangedEventClass;
		  multiple: self isMultipleSelection;
		  commandApplicationStrategy: commandApplicationStrategy;
		  yourself
]

{ #category : #operations }
ToPrimarySelecter >> selectIndex: anArray [

	super selectIndex: anArray
]

{ #category : #operations }
ToPrimarySelecter >> selectIndexes: anArray [

	"self halt."
	super selectIndexes: anArray
]
