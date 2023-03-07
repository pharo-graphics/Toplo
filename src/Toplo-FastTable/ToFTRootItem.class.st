"
I represent the root item node in a ToFTTreeDataSource.

Description
-------------------------------------------------

I am store by a ToFTTreeDataSource and my children are the roots elements of the dataSource.
I store the a collection of Items build from the data of the dataSource.


Example
-------------------------------------------------
 
ToFTRootItem data: Object allSubclasses from: aDataSource
"
Class {
	#name : #ToFTRootItem,
	#superclass : #ToFTTreeItem,
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #accessing }
ToFTRootItem >> children [
	^ children
]

{ #category : #accessing }
ToFTRootItem >> children: aCollectionOfItem [
	children := aCollectionOfItem
]

{ #category : #'expanding-collapsing' }
ToFTRootItem >> collapseAll [
	children do: #collapseAll
]

{ #category : #accessing }
ToFTRootItem >> data: aCollection [
	self children: (aCollection collect: [ :object | ToFTBasicItem data: object from: dataSource ]) asArray
]

{ #category : #accessing }
ToFTRootItem >> dataSource: anObject [
	dataSource := anObject.
	children ifNotNil: [ children do: [ :item | item dataSource: anObject ] ]
]

{ #category : #'expanding-collapsing' }
ToFTRootItem >> expandAll [
	children do: #expandAll
]

{ #category : #'expanding-collapsing' }
ToFTRootItem >> expandAllTo: aDepth [
	children do: [ :each | each expandAllTo: aDepth ]
]

{ #category : #accessing }
ToFTRootItem >> isExpanded [
	^ true
]

{ #category : #accessing }
ToFTRootItem >> recentlyChanged [
	"Cannot collapse root item."

	^ false
]

{ #category : #updating }
ToFTRootItem >> updateData [
	self children do: #updateData
]
