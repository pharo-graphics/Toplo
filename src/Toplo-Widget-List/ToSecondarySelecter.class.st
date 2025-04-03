Class {
	#name : #ToSecondarySelecter,
	#superclass : #ToListSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #initialization }
ToSecondarySelecter >> defaultCommandApplicationStrategy [

	"^ ToDataSourceCommandApplicationStrategy new"
	^ ToImmediateCommandApplicationStrategy new
]
