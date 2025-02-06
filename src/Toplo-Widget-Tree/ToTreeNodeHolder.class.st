Class {
	#name : #ToTreeNodeHolder,
	#superclass : #ToListNodeHolder,
	#instVars : [
		'dataWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeNodeHolder >> bindDataItem: aDataItem [

	super bindDataItem: aDataItem.
	"self childSelector dataItem: aDataItem"
]

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
ToTreeNodeHolder >> dataItem [

	^ dataItem
	"self childSelector dataItem"
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
	dataWrapper nodeHolder: self.
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
