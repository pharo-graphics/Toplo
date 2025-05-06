Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToListSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSecondarySelecter >> defaultCommandApplicationStrategy [

	"Should not return a ToDataSourceCommandApplicationStrategy to avoid infinite 
	recursion because the last mouse move event is replayed when layout is done 
	in ToInfiniteElement>>onLayoutDone (and the secondary selection is updated when mouse move ) "
	^ ToImmediateCommandApplicationStrategy new
]
