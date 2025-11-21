"
I am a ToTreeNodeHolder

My purpose is to hold a reference to a DataSourceWrapper so the TreeNode bound to me can access the data it has to display.

I am dynamically created/destroyed by the NodeManager each time I enter/leave the widget view.
This is because of this property that we need a DataSourceWrapper that will not be created/destroyed dynamically in the model otherwise I would have to calcute references to the data children each time I am created.
This also explains why my API mainly refers to the dataWrapper API.

 
"
Class {
	#name : #ToTreeNodeHolder,
	#superclass : #ToNodeHolder,
	#instVars : [
		'dataWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeNodeHolder >> bindDataItem: aDataItem [
	" associate the data item and then build the node "

	dataWrapper := aDataItem.
	self flag: 'The recycling case have to be re-worked'.
	" I can already have a node in case of recycling "
	self node ifNotNil: [ ^ self ].
	self setupNodeWith: (self nodeManager newNodeForHolder: self).
	self dataItem: aDataItem unwrappedDataItem.
	self nodeManager buildNode: self node
]

{ #category : #accessing }
ToTreeNodeHolder >> dataWrapper [

	^ dataWrapper
]

{ #category : #accessing }
ToTreeNodeHolder >> treeDataItem [ 

	^ dataItem 
]
