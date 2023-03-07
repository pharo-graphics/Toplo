"
I am an Item of a tree that keep a data and I keep staticly my children. I cannot regenerate them. 

Description
-------------------------------------------------

I am created by a ToFTTreeFunctionStrategy for some filter. For example it is hard to be able to update a Tree when you filter all his elements. In that case the ToFTAllItemsStrategy create me during a filter.

Public API and Key Messages
-------------------------------------------------

- #children: 	allow to set my childrens 
   
Example
-------------------------------------------------

ToFTStaticBasicItem new
		data: 5;
		depth: 2;
		children: aCollectionOfItems;
		yourself.
 
"
Class {
	#name : #ToFTStaticBasicItem,
	#superclass : #ToFTBasicItem,
	#category : #'Toplo-FastTable-Tree'
}

{ #category : #accessing }
ToFTStaticBasicItem >> calculateChildren [
	"Not for this item."
]

{ #category : #accessing }
ToFTStaticBasicItem >> children [
	^ children
]

{ #category : #accessing }
ToFTStaticBasicItem >> children: aCollectionsOfItems [
	children := aCollectionsOfItems
]

{ #category : #updating }
ToFTStaticBasicItem >> dataSource: anObject [
	dataSource := anObject.
	children do: [ :item | item dataSource: anObject ]
]

{ #category : #updating }
ToFTStaticBasicItem >> updateData [
	"Static Item cannot do it."
]
