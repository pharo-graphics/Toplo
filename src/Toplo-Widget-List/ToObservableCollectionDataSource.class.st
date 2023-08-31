Class {
	#name : #ToObservableCollectionDataSource,
	#superclass : #ToListDataSource,
	#instVars : [
		'data'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #accessing }
ToObservableCollectionDataSource >> data [

	^ data
]

{ #category : #accessing }
ToObservableCollectionDataSource >> data: anObservableCollection [

	data := anObservableCollection.
	data whenAddChangeDo: [ :ann | self notifyItemsInserted: ann interval ].
	data whenRemoveChangeDo: [ :ann | self notifyItemsRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann | self notifyItemsChanged: ann interval ].
	data whenBeforeFilterChangeDo: [ :ann | self notifyItemsRemoved: ann interval ]. 
	data whenFilterChangeDo: [ :ann | self notifyItemsInserted: ann interval ].
	data when: ToCollectionEmptinessEvent do: [ self dispatchEvent: ToListDataEmptinessChangeEvent new  ].

	self notifyChanged
]

{ #category : #accessing }
ToObservableCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self data ifNil: [0] ifNotNil: [:l | l size]
]

{ #category : #accessing }
ToObservableCollectionDataSource >> list [

	self 
		deprecated:  'Use #data instead' 
		transformWith: '`@receiver list' -> '`@receiver data'.
	^ self data	
]

{ #category : #accessing }
ToObservableCollectionDataSource >> list: anObservableCollection [

	self
		deprecated: 'Please use data: instead.'
		transformWith:
			'`@receiver list: `@col'
				-> '`@receiver data: `@col'.
	^ self data: anObservableCollection
]

{ #category : #'instance creation' }
ToObservableCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [

	"Update holder's model"
	anElementHolder data: (self data at: aPosition).

]
