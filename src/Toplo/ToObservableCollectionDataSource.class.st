Class {
	#name : #ToObservableCollectionDataSource,
	#superclass : #ToListDataSource,
	#instVars : [
		'list'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToObservableCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self list ifNil: [0] ifNotNil: [:l | l size]
]

{ #category : #accessing }
ToObservableCollectionDataSource >> list [

	^ list
]

{ #category : #accessing }
ToObservableCollectionDataSource >> list: anObservableCollection [

	list := anObservableCollection.
	list whenAddChangeDo: [ :ann | self notifyItemsInserted: ann interval ].
	list whenRemoveChangeDo: [ :ann | self notifyItemsRemoved: ann interval ].
	list whenUpdateChangeDo: [ :ann | self notifyItemsChanged: ann interval ].
	list whenBeforeFilterChangeDo: [ :ann | self notifyItemsRemoved: ann interval ]. 
	list whenFilterChangeDo: [ :ann | self notifyItemsInserted: ann interval ].
	list whenAnnouncement: ToCollectionEmptinessChanged do: [ self dispatchEvent: ToListDataEmptinessChangeEvent new  ].

	self notifyChanged
]

{ #category : #'instance creation' }
ToObservableCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [

	"Update holder's model"
	anElementHolder data: (self list at: aPosition).

]
