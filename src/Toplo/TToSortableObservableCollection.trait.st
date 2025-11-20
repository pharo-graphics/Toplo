Trait {
	#name : #TToSortableObservableCollection,
	#category : #'Toplo-Core-Collection'
}

{ #category : #'t - sortable observable collection - sorting' }
TToSortableObservableCollection >> sort: aSortBlock [

	self collection sort: aSortBlock.
	self notifyUpdatedInterval: (1 to: self size)
]
