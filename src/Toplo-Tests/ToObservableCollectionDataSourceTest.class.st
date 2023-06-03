"
A ToObservableCollectionDataSourceTest is a test class for testing the behavior of ToObservableCollectionDataSource
"
Class {
	#name : #ToObservableCollectionDataSourceTest,
	#superclass : #ToInfiniteTest,
	#category : #'Toplo-Tests-Widget-List'
}

{ #category : #tests }
ToObservableCollectionDataSourceTest >> testRangeChangedNotification [

	| datasource rangeEvent |
	datasource := ToObservableCollectionDataSource new.
	datasource when: OBlInfiniteDataSourceItemRangeChanged do: [ :event | rangeEvent := event].
	datasource list: ToObservableCollection new.
	datasource list addAll: self statesOfAmerica.
	self assert: rangeEvent isNil.
	
	datasource list at: 2 put: nil.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 1.
	self assert: datasource itemCount equals: datasource list size.
	
	datasource list replaceFrom: 2 to: 10 with: ((2 to: 10) collect: [:p | p]) startingAt: 1.
	(2 to: 10 ) do: [ :p | self assert: (datasource list at: p) equals: p ].
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 9

]

{ #category : #tests }
ToObservableCollectionDataSourceTest >> testRangeInsertedNotification [

	| datasource rangeEvent |
	datasource := ToObservableCollectionDataSource new.
	datasource when: OBlInfiniteDataSourceItemRangeInserted do: [ :event | rangeEvent := event].
	datasource list: ToObservableCollection new.
	datasource list addAll: self statesOfAmerica.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 1.
	self assert: rangeEvent itemCount equals: self statesOfAmerica size.
	self assert: datasource itemCount equals: datasource list size.
	datasource list add: Object new afterIndex: 1.
	self assert: rangeEvent position equals: 2.
	self assert: rangeEvent itemCount equals: 1.

]

{ #category : #tests }
ToObservableCollectionDataSourceTest >> testRangeRemovedNotification [

	| datasource rangeEvent |
	datasource := ToObservableCollectionDataSource new.
	datasource when: OBlInfiniteDataSourceItemRangeRemoved do: [ :event | rangeEvent := event].
	datasource list: ToObservableCollection new.
	datasource list addAll: self statesOfAmerica.
	datasource list remove: self statesOfAmerica first.
	self assert: rangeEvent notNil.
	self assert: rangeEvent position equals: 1.
	self assert: rangeEvent itemCount equals: 1.
	self assert: datasource itemCount equals: self statesOfAmerica size - 1.
	datasource list remove: self statesOfAmerica last.
	self assert: rangeEvent position equals: self statesOfAmerica size - 1.
	self assert: rangeEvent itemCount equals: 1.
	self assert: datasource itemCount equals: self statesOfAmerica size - 2.
	datasource list removeAll.
	self assert: rangeEvent position equals: 1.
	self assert: rangeEvent itemCount equals: self statesOfAmerica size - 2.

]

{ #category : #tests }
ToObservableCollectionDataSourceTest >> testWithData [

	| datasource changedEvent |
	datasource := ToObservableCollectionDataSource new.
	datasource when: OBlInfiniteDataSourceChanged do: [ :event | changedEvent := event ].
	datasource list: (ToObservableCollection newFrom: self statesOfAmerica ).
	self assert: changedEvent notNil.
	self assert: changedEvent dataSource equals: datasource.
	self assert: datasource itemCount equals: self statesOfAmerica size.
	self assert: datasource hasStableIds not

]

{ #category : #tests }
ToObservableCollectionDataSourceTest >> testWithoutData [

	| datasource |
	datasource := ToObservableCollectionDataSource new.
	self assert: datasource list isNil.
	self assert: datasource itemCount equals: 0.
	self assert: datasource hasStableIds not
]
