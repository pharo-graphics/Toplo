Class {
	#name : #ToListSelectionStrategyDep,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #'mode changing' }
ToListSelectionStrategyDep >> beWithoutSelection [
]

{ #category : #'selection event dispatching' }
ToListSelectionStrategyDep >> dispatchSelectionChangedAfter: aBlock [
]

{ #category : #'selection event dispatching' }
ToListSelectionStrategyDep >> dispatchSelectionDirtyAfter: aBlock [


]

{ #category : #'selection event dispatching' }
ToListSelectionStrategyDep >> dispatchStrongSelectionChanged [


]

{ #category : #'event management accessing' }
ToListSelectionStrategyDep >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'selection accessing' }
ToListSelectionStrategyDep >> includes: anIndex [

	^ false
]

{ #category : #initialization }
ToListSelectionStrategyDep >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.

]

{ #category : #'selection and shortcuts handlers' }
ToListSelectionStrategyDep >> onAddedNode: aNode [


]

{ #category : #'data source change' }
ToListSelectionStrategyDep >> onInfiniteDataSourceChanged [
]

{ #category : #'api - hooks' }
ToListSelectionStrategyDep >> onInstalledIn: anInfiniteElement [
]

{ #category : #'selection and shortcuts handlers' }
ToListSelectionStrategyDep >> onRemovedNode: aNode [


]

{ #category : #'api - hooks' }
ToListSelectionStrategyDep >> onUninstalledIn: anInfiniteElement [
]

{ #category : #initialization }
ToListSelectionStrategyDep >> renewSelectionModel [
]

{ #category : #'api - selection' }
ToListSelectionStrategyDep >> selectAll [
]

{ #category : #'selection accessing' }
ToListSelectionStrategyDep >> selectedIndexes [

	^ { }
]

{ #category : #accessing }
ToListSelectionStrategyDep >> selectionModel [

	^ nil
]

{ #category : #accessing }
ToListSelectionStrategyDep >> selectionModel: aSelection [
]

{ #category : #'data source change' }
ToListSelectionStrategyDep >> shiftAfterAddingAt: aStartPosition itemCount: anItemCount [

]

{ #category : #'data source change' }
ToListSelectionStrategyDep >> shiftAfterRemovingAt: aStartPosition itemCount: anItemCount [
]
