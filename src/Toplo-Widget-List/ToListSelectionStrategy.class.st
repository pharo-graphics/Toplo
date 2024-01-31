Class {
	#name : #ToListSelectionStrategy,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'eventDispatcher'
	],
	#category : #'Toplo-Widget-List-Selection-Strategy'
}

{ #category : #'mode changing' }
ToListSelectionStrategy >> beWithoutSelection [
]

{ #category : #'selection event dispatching' }
ToListSelectionStrategy >> dispatchSelectionChangedAfter: aBlock [
]

{ #category : #'selection event dispatching' }
ToListSelectionStrategy >> dispatchSelectionDirtyAfter: aBlock [


]

{ #category : #'selection event dispatching' }
ToListSelectionStrategy >> dispatchStrongSelectionChanged [


]

{ #category : #'event management accessing' }
ToListSelectionStrategy >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> includes: anIndex [

	^ false
]

{ #category : #initialization }
ToListSelectionStrategy >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.

]

{ #category : #'selection and shortcuts handlers' }
ToListSelectionStrategy >> onAddedNode: aNode [


]

{ #category : #'data source change' }
ToListSelectionStrategy >> onInfiniteDataSourceChanged [
]

{ #category : #'api - hooks' }
ToListSelectionStrategy >> onInstalledIn: anInfiniteElement [
]

{ #category : #'selection and shortcuts handlers' }
ToListSelectionStrategy >> onRemovedNode: aNode [


]

{ #category : #'api - hooks' }
ToListSelectionStrategy >> onUninstalledIn: anInfiniteElement [
]

{ #category : #initialization }
ToListSelectionStrategy >> renewSelectionModel [
]

{ #category : #'api - selection' }
ToListSelectionStrategy >> selectAll [
]

{ #category : #'selection accessing' }
ToListSelectionStrategy >> selectedIndexes [

	^ { }
]

{ #category : #accessing }
ToListSelectionStrategy >> selectionModel [

	^ nil
]

{ #category : #accessing }
ToListSelectionStrategy >> selectionModel: aSelection [
]

{ #category : #'data source change' }
ToListSelectionStrategy >> shiftAfterAddingAt: aStartPosition itemCount: anItemCount [

]

{ #category : #'data source change' }
ToListSelectionStrategy >> shiftAfterRemovingAt: aStartPosition itemCount: anItemCount [
]
