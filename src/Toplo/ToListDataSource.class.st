Class {
	#name : #ToListDataSource,
	#superclass : #OBlInfiniteDataSource,
	#instVars : [
		'list'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToListDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ list size
]

{ #category : #accessing }
ToListDataSource >> list [

	^ list
]

{ #category : #accessing }
ToListDataSource >> list: aList [

	list := aList.
	list whenAddChangeDo: [ :ann | 
		self notifyItemsInserted: ann interval ].
	list whenRemoveChangeDo: [ :ann | 
		self notifyItemsRemoved: ann interval ].
	list whenUpdateChangeDo: [ :ann | 
		self notifyItemsChanged: ann interval ].

	self notifyChanged
]

{ #category : #'instance creation' }
ToListDataSource >> onBindHolder: anElementHolder at: aPosition [

	"Update holder's model"
	anElementHolder data: (list at: aPosition).

]

{ #category : #'instance creation' }
ToListDataSource >> onCreateHolder: anInfiniteElement [ 

	^ anInfiniteElement holderClass new infiniteElement: anInfiniteElement 
]

{ #category : #'instance creation' }
ToListDataSource >> onElementAttached: anElementHolder [

	| dresser |
	super onElementAttached: anElementHolder.
	anElementHolder itemElement holder: anElementHolder.
	dresser := ToNodeDresser new.
	anElementHolder dressNodeWith: dresser.
	(anElementHolder infiniteElement selectionModel contains:
		 anElementHolder layoutPosition) ifTrue: [ 
		dresser addedToSelection: anElementHolder itemElement ].
	anElementHolder
		whenAnnouncement: ToClickOnNodeAnnouncement
		send: #whenClickOnNodeAnnouncement:
		to: anElementHolder infiniteElement
]

{ #category : #'instance creation' }
ToListDataSource >> onElementDetached: anElementHolder [
	
	super onElementDetached: anElementHolder.
	anElementHolder unsubscribe: self.
	anElementHolder undressNode.
	anElementHolder itemElement holder: nil.
]
