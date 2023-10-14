Class {
	#name : 'ToListObservableCollectionDataSource',
	#superclass : 'ToListDataSource',
	#instVars : [
		'data'
	],
	#category : 'Toplo-Widget-List-infinite',
	#package : 'Toplo-Widget-List',
	#tag : 'infinite'
}

{ #category : 'accessing' }
ToListObservableCollectionDataSource >> data [

	^ data
]

{ #category : 'accessing' }
ToListObservableCollectionDataSource >> data: anObservableCollection [

	data := anObservableCollection.
	data whenAddChangeDo: [ :ann | self notifyItemsInserted: ann interval ].
	data whenRemoveChangeDo: [ :ann | self notifyItemsRemoved: ann interval ].
	data whenUpdateChangeDo: [ :ann | self notifyItemsChanged: ann interval ].
	data whenBeforeFilterChangeDo: [ :ann | self notifyItemsRemoved: ann interval ]. 
	data whenFilterChangeDo: [ :ann | self notifyItemsInserted: ann interval ].
	data when: ToCollectionEmptinessEvent do: [ self dispatchEvent: ToDataEmptinessChangeEvent new  ].

	self notifyChanged
]

{ #category : 'accessing' }
ToListObservableCollectionDataSource >> itemCount [
	"Return the total number of items in the data set"
	<return: #Number>

	^ self data ifNil: [0] ifNotNil: [:l | l size]
]

{ #category : 'accessing' }
ToListObservableCollectionDataSource >> list [

	self 
		deprecated:  'Use #data instead' 
		transformWith: '`@receiver list' -> '`@receiver data'.
	^ self data	
]

{ #category : 'accessing' }
ToListObservableCollectionDataSource >> list: anObservableCollection [

	self
		deprecated: 'Please use data: instead.'
		transformWith:
			'`@receiver list: `@col'
				-> '`@receiver data: `@col'.
	^ self data: anObservableCollection
]

{ #category : 'instance creation' }
ToListObservableCollectionDataSource >> onBindHolder: anElementHolder at: aPosition [

	"Update holder's model"
	anElementHolder data: (self data at: aPosition).

]
