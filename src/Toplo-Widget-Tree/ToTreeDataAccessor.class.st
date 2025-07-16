Class {
	#name : #ToTreeDataAccessor,
	#superclass : #Object,
	#traits : 'TToDataSourceWrapper + TBlEventTarget + TBlDebug',
	#classTraits : 'TToDataSourceWrapper classTrait + TBlEventTarget classTrait + TBlDebug classTrait',
	#instVars : [
		'treeElement',
		'parentWrapper',
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #'t - data source wrapper - accessing dataSource' }
ToTreeDataAccessor >> dataSource [

	^ treeElement dataSource
]

{ #category : #private }
ToTreeDataAccessor >> errorSizeMismatch [
	"Signal a SizeMismatch exception"

	SizeMismatch signal
]

{ #category : #'event management accessing' }
ToTreeDataAccessor >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher 
]

{ #category : #initialization }
ToTreeDataAccessor >> initialize [

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self
]

{ #category : #private }
ToTreeDataAccessor >> invalidOperation [

	Error signal: 'Invalid data accessor operation'
]

{ #category : #'t - data source wrapper - accessing dataSource' }
ToTreeDataAccessor >> newWrapperForDataItem: anObject [

	^ ToTreeDataItemWrapper new
		  treeElement: treeElement;
		  parentWrapper: parentWrapper;
		  dataItem: anObject
]

{ #category : #private }
ToTreeDataAccessor >> species [ 

	^ OrderedCollection 
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement [

	^ treeElement
]

{ #category : #accessing }
ToTreeDataAccessor >> treeElement: aTreeElement [

	treeElement := aTreeElement
]

{ #category : #'t - data source wrapper - accessing dataSource' }
ToTreeDataAccessor >> unwrappedDataItemAt: anInteger [ 

	^ (self dataSource at: anInteger) unwrappedDataItem
]

{ #category : #'accessing - dataSource' }
ToTreeDataAccessor >> useParentWrapper: aWrapper while: aBlock [

	| previous |
	previous := parentWrapper.
	parentWrapper := aWrapper.
	aBlock value.
	parentWrapper := previous
]
