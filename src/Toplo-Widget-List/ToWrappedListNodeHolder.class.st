"
I am a ToTreeNodeHolder

My purpose is to hold a reference to a DataSourceWrapper so the TreeNode bound to me can access the data it has to display.

I am dynamically created/destroyed by the NodeManager each time I enter/leave the widget view.
This is because of this property that we need a DataSourceWrapper that will not be created/destroyed dynamically in the model otherwise I would have to calcute references to the data children each time I am created.
This also explains why my API mainly refers to the dataWrapper API.

 
"
Class {
	#name : #ToWrappedListNodeHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'dataWrapper'
	],
	#category : #'Toplo-Widget-List-WrappedList'
}

{ #category : #accessing }
ToWrappedListNodeHolder >> bindDataItem: aDataItem [

	dataWrapper := aDataItem.
	super bindDataItem: aDataItem
]

{ #category : #accessing }
ToWrappedListNodeHolder >> dataWrapper [

	^ dataWrapper
]

{ #category : #accessing }
ToWrappedListNodeHolder >> fakeDataItem: aDataItem [
	"Notice that for wrapped list node, the arguments is the actual data (and not the wrapper as it is in #bindDataItem: ) "

	| dataAccessor |
	dataAccessor := self listElement dataAccessor.
	dataWrapper := dataAccessor newWrapperForDataItem: aDataItem.
	super fakeDataItem: dataWrapper
]

{ #category : #accessing }
ToWrappedListNodeHolder >> unwrappedDataItemFrom: aDataItem [

	^ aDataItem unwrappedDataItem 
]
