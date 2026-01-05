Class {
	#name : #ToFiniteListDataSourceManager,
	#superclass : #Object,
	#traits : 'TToPostponedCommandManager',
	#classTraits : 'TToPostponedCommandManager classTrait',
	#instVars : [
		'innerListElement'
	],
	#category : #'Toplo-Widget-List-InnerList-Finite'
}

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> dispatchCommand: aCommand to: anInfiniteElement [
	"Dispatch data source update command to all interested objects,
	in this case to infinite element's layout.
	aCommand must not be nil"
	
	aCommand dispatchToLayout: anInfiniteElement layout
]

{ #category : #accessing }
ToFiniteListDataSourceManager >> innerListElement: anInnerBarElement [

	innerListElement := anInnerBarElement
]

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> onCommandProcessed: aCommand in: anInfiniteElement [

	aCommand offsetPositionsIn: anInfiniteElement.
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeChanged: aPositionStart itemCount: anItemCount [

	innerListElement onItemRangeChanged: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeInserted: aPositionStart itemCount: anItemCount [

	innerListElement onItemRangeInserted: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemRangeRemoved: aPositionStart itemCount: anItemCount [

	innerListElement onItemRangeRemoved: aPositionStart itemCount: anItemCount
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemsChanged [

	innerListElement onItemsChanged
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemsFiltered: aPositionStart itemCount: anItemCount [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register add command"
	self postponeCommand: (ToListDataSourceFilterCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 yourself).
	^ true
]

{ #category : #'data source updates' }
ToFiniteListDataSourceManager >> onItemsSieved: aPositionStart itemCount: anItemCount with: aSieve [
	"Return true if pending commands should be processed,
	otherwise false"

	"Register the sieve command"
	self postponeCommand: (ToListDataSourceSieveCommand new
			 positionStart: aPositionStart;
			 itemCount: anItemCount;
			 sieve: aSieve;
			 yourself).
	^ true
]

{ #category : #'commands processing' }
ToFiniteListDataSourceManager >> recycleCommand: aCommand [
	"Recycle aCommand if recycling enabled"

]
