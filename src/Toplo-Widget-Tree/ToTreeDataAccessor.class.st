"
I am a ToTreeDataSourceWrapper 

My job is to wrap objects that users wish to add to a dataSource of a TreeElement, I present a similar API than a dataSource but I take care of using DataItemWrappers to wrap objects before putting them into the dataSource


"
Class {
	#name : #ToTreeDataAccessor,
	#superclass : #ToObservableCollection,
	#instVars : [
		'treeElement',
		'parentWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeDataAccessor >> dataSource [ 

	^ treeElement dataSource
]

{ #category : #accessing }
ToTreeDataAccessor >> dataWrapperClass [ 

	^ ToTreeDataItemWrapper
]

{ #category : #initialization }
ToTreeDataAccessor >> initialize [

	super initialize.
	self addEventHandler: ToTreeDataAccessorEventHandler new
]

{ #category : #wrapping }
ToTreeDataAccessor >> newWrapperAt: aPosition [

	^ self dataWrapperClass new
		  treeElement: treeElement;
		  parentWrapper: parentWrapper;
		  dataItem: (self at: aPosition);
		  yourself
]

{ #category : #wrapping }
ToTreeDataAccessor >> newWrapperFor: anObject [

	^ self dataWrapperClass new
		  treeElement: treeElement;
		  parentWrapper: parentWrapper;
		  dataItem: anObject
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement [

	^ treeElement
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement: aTreeElement [

	treeElement := aTreeElement 
]

{ #category : #private }
ToTreeDataAccessor >> useParentWrapper: aWrapper while: aBlock [

	| previous |
	previous := parentWrapper.
	parentWrapper := aWrapper.
	aBlock value.
	parentWrapper := previous
]
