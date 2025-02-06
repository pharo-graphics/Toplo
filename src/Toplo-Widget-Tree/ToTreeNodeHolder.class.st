"
I am a ToTreeNodeHolder

My purpose is to hold a reference to a DataSourceWrapper so the TreeNode bound to me can access the data it has to display.

I am dynamically created/destroyed by the NodeManager each time I enter/leave the widget view.
This is because of this property that we need a DataSourceWrapper that will not be created/destroyed dynamically in the model otherwise I would have to calcute references to the data children each time I am created.
This also explains why my API mainly refers to the dataWrapper API.

 
"
Class {
	#name : #ToTreeNodeHolder,
	#superclass : #ToListNodeHolder,
	#instVars : [
		'dataWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeNodeHolder >> children [

	^ self dataWrapper children
]

{ #category : #public }
ToTreeNodeHolder >> click [

	self isCollapsed 
		ifTrue: [ self dataWrapper expand ]
		ifFalse: [ self dataWrapper collapse ]
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> collapse [

	self dataWrapper collapse
]

{ #category : #accessing }
ToTreeNodeHolder >> dataItem: aDataItem [ 

	self dataWrapper: aDataItem.
	dataItem := aDataItem dataItem
]

{ #category : #accessing }
ToTreeNodeHolder >> dataWrapper [

	^ dataWrapper
]

{ #category : #accessing }
ToTreeNodeHolder >> dataWrapper: aToTreeDataSourceWrapper [

	dataWrapper := aToTreeDataSourceWrapper.
]

{ #category : #'expanding-collapsing' }
ToTreeNodeHolder >> expand [

	self dataWrapper expand.
]

{ #category : #accessing }
ToTreeNodeHolder >> isCollapsed [

	^ self dataWrapper isCollapsed 
]

{ #category : #testing }
ToTreeNodeHolder >> isLeaf [

	^ self wrapper isLeaf
]
