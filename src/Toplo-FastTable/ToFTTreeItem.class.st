"
I am an abstract class to define an Item use by a tree data source of Fast table.

Description
-------------------------------------------------

I define the basics methods needed by a ToFTTreeDataSource. 
I use ToFTTreeItem to manage my elements and I am use by a ToFTFastTable.

Public API and Key Messages
-------------------------------------------------

- #data. anObject from: aToFTTreeDataSource
	This is my constructor that is use by ToFTTreeDataSource and myself
	
Example
-------------------------------------------------

Should not be instanciate.
 
Internal Representation and Key Implementation Points.
-------------------------------------------------

    Instance Variables
	dataSource:		I am the dataSource that holds this Item. 
	children:		I am a collection of Items calculate by the item. I contains the chldren of the Item.


"
Class {
	#name : #ToFTTreeItem,
	#superclass : #Object,
	#instVars : [
		'dataSource',
		'children'
	],
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #'instance creation' }
ToFTTreeItem class >> data: aData from: aDataSource [
	^ self new
		dataSource: aDataSource;
		data: aData;
		yourself
]

{ #category : #accessing }
ToFTTreeItem >> childAt: anIndex [
	| tmpIndex |
	tmpIndex := anIndex.
	self children
		do:
			[ :item |
			| size |
			size := item numberOfVisibleChildren + 1.
			tmpIndex <= size
				ifTrue: [ ^ item selfOrChildAt: tmpIndex ]
				ifFalse: [ tmpIndex := tmpIndex - size ] ].
	self errorSubscriptBounds: anIndex
]

{ #category : #accessing }
ToFTTreeItem >> children [
	self subclassResponsibility
]

{ #category : #'expanding-collapsing' }
ToFTTreeItem >> collapseAll [
	self subclassResponsibility
]

{ #category : #accessing }
ToFTTreeItem >> data: aData [
	self subclassResponsibility
]

{ #category : #accessing }
ToFTTreeItem >> dataSource [
	^ dataSource
]

{ #category : #accessing }
ToFTTreeItem >> dataSource: anObject [
	dataSource := anObject
]

{ #category : #'expanding-collapsing' }
ToFTTreeItem >> expandAll [
	self subclassResponsibility
]

{ #category : #'expanding-collapsing' }
ToFTTreeItem >> expandAllTo: aDepth [
	self subclassResponsibility
]

{ #category : #testing }
ToFTTreeItem >> hasChildren [
	^ self children size ~= 0
]

{ #category : #updating }
ToFTTreeItem >> isExpanded [
	^ self subclassResponsibility
]

{ #category : #accessing }
ToFTTreeItem >> numberOfChildren [
	^ self children
		ifEmpty: [ 0 ]
		ifNotEmpty: [ :children2 | children2 size + (children2 collect: [ :item | item numberOfChildren ]) sum ]
]

{ #category : #accessing }
ToFTTreeItem >> numberOfVisibleChildren [
	^ (self isExpanded and: [ self children isNotEmpty ])
		ifTrue: [ self children size + (self children collect: [ :item | item numberOfVisibleChildren ]) sum ]
		ifFalse: [ 0 ]
]

{ #category : #accessing }
ToFTTreeItem >> recentlyChanged [
	"I return true if the item was recently collapsed. I am use to update the selection when we collapse an item."

	self subclassResponsibility
]

{ #category : #updating }
ToFTTreeItem >> selectedRowsIndexesFrom: anInteger [
	| index selfSelection |
	index := anInteger.
	self recentlyChanged
		ifTrue: [ ^ (self dataSource table selectedIndexes select: [ :each | each between: index and: index + self numberOfVisibleChildren ]) ifEmpty: [ {} ] ifNotEmpty: [ {index} ] ].
	selfSelection := (self dataSource table selectedIndexes includes: index)
		ifTrue: [ {index} ]
		ifFalse: [ {} ].
	self isExpanded
		ifFalse: [ ^ selfSelection ].
	index := index + 1.
	^ (self children
		flatCollect: [ :child |
			| result |
			result := child selectedRowsIndexesFrom: index.
			index := index + 1 + child numberOfVisibleChildren.
			result ]) , selfSelection
]

{ #category : #accessing }
ToFTTreeItem >> selfOrChildAt: anIndex [
	^ anIndex = 1
		ifTrue: [ self ]
		ifFalse: [ self childAt: anIndex - 1 ]
]

{ #category : #updating }
ToFTTreeItem >> updateData [
	self subclassResponsibility
]
