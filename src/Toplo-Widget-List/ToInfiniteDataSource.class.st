Class {
	#name : #ToInfiniteDataSource,
	#superclass : #BlInfiniteDataSource,
	#category : #'Toplo-Widget-List-InnerInfinite'
}

{ #category : #accessing }
ToInfiniteDataSource >> dataAccessor [

	^ self subclassResponsibility 
]

{ #category : #'event firing' }
ToInfiniteDataSource >> notifyItemsFiltered [
	"Notify any registered observers that data source have been newly filtered.
	This is a structural change event"

	self notifyWithEvent: (ToInfiniteDataSourceItemsFiltered
			 position: 1
			 itemCount: self itemCount)
]

{ #category : #'event firing' }
ToInfiniteDataSource >> notifyItemsSievedWith: aSieve [
	"Notify any registered observers that data source have been newly filtered.
	This is a structural change event"

	self notifyWithEvent: (ToInfiniteDataSourceItemsSieved
		position: 1
		itemCount: self itemCount
		sieve: aSieve )
]

{ #category : #'event firing' }
ToInfiniteDataSource >> notifySelecterCommandApplicationRequest: aCommand from: aSelecter [
	"Notify any registered observers that a selecter request the application of a command.
	This is not a structural change event"

	self notifyWithEvent: (ToSelecterCommandApplicationRequest new
			 selecter: aSelecter;
			 command: aCommand;
			 yourself)
]

{ #category : #'instance creation' }
ToInfiniteDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement newNodeHolderFromDataSource: self
]
