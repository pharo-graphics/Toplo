Class {
	#name : #ToTreeDataAccessor,
	#superclass : #ToWrappedListDataAccessor,
	#instVars : [
		'parentWrapper'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - data source wrapper - accessing dataSource' }
ToTreeDataAccessor >> dataItemWrapperClass [

	^ ToTreeDataItemWrapper 
]

{ #category : #private }
ToTreeDataAccessor >> errorSizeMismatch [
	"Signal a SizeMismatch exception"

	SizeMismatch signal
]

{ #category : #private }
ToTreeDataAccessor >> invalidOperation [

	Error signal: 'Invalid data accessor operation'
]

{ #category : #'t - data source wrapper - accessing dataSource' }
ToTreeDataAccessor >> newWrapperForDataItem: anObject [

	^ (super newWrapperForDataItem: anObject)
		  parentWrapper: parentWrapper;
		  yourself
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement [

	^ self listElement
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement: aTreeElement [

	self listElement: aTreeElement
]

{ #category : #'accessing - dataSource' }
ToTreeDataAccessor >> useParentWrapper: aWrapper while: aBlock [

	| previous |
	previous := parentWrapper.
	parentWrapper := aWrapper.
	aBlock value.
	parentWrapper := previous
]
