Class {
	#name : #ToInfiniteObservableCollectionDataSource,
	#superclass : #ToInfiniteDataSource,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-List-Infinite'
}

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> data [

	^ data
]

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> data: anObservableCollection [

	data := anObservableCollection.
	data whenAddChangeDo: [ :ann |
		self notifyItemsInserted: ann interval ].
	data whenRemoveChangeDo: [ :ann |
		self notifyItemsRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann |
		self notifyItemsChanged: ann interval ].
	data whenBeforeFilterChangeDo: [ :ann |
		self notifyItemsRemoved: ann interval ].
	data whenFilterChangeDo: [ :ann |
		self notifyItemsInserted: ann interval ].

	self notifyChanged
]

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self data ifNil: [0] ifNotNil: [:l | l size]
]

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> list [

	self 
		deprecated:  'Use #data instead' 
		transformWith: '`@receiver list' -> '`@receiver data'.
	^ self data	
]

{ #category : #accessing }
ToInfiniteObservableCollectionDataSource >> list: anObservableCollection [

	self
		deprecated: 'Please use data: instead.'
		transformWith:
			'`@receiver list: `@col'
				-> '`@receiver data: `@col'.
	^ self data: anObservableCollection
]

{ #category : #'instance creation' }
ToInfiniteObservableCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [

	"Update holder's model"
	anElementHolder data: (self data at: aPosition).

]
