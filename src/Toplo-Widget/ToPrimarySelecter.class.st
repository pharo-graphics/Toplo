Class {
	#name : #ToPrimarySelecter,
	#superclass : #ToCompositeSelecter,
	#category : #'Toplo-Widget-List'
}

{ #category : #'instance creation' }
ToPrimarySelecter >> newSieveSelecter [

	^ ToSieveSelecter new
		  selectionModel: selectionModel copy;
		  selectionChangedEventClass: selectionChangedEventClass;
		  multiple: self isMultipleSelection;
		  commandApplicationStrategy: commandApplicationStrategy;
		  yourself
]
